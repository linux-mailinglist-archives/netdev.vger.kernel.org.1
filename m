Return-Path: <netdev+bounces-260963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGarNNf+nmlAYgQAu9opvQ
	(envelope-from <netdev+bounces-260963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:53:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49228198649
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A41EC303CEED
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406963C199E;
	Wed, 25 Feb 2026 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="oPrcLuzK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3FD396B9F
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027314; cv=pass; b=uhKF9ezrwif4t4xzZRuH1cKnJrWoc75weOx76oBGPVSBPf/uIFNFJ4iwvdINkd2gIje6b0bEw9uy9AOgP2l9atkdPClsa9uW10SlWpviZk9EOzhr7L2iKwhn8gA2dsAk2+W7gnYTvEaDB3cxg9ND0fMnU8T2Ht2B9aIS0Tct6ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027314; c=relaxed/simple;
	bh=SssUEHOHY/uF1odyg5G0fB8AX0zxj3pYD2qqdMBOJes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZvklQc7Cs5nQdnCeb7F7JKpguuKmP/YfJ1rE9XPDwkR97+FpqI9cZH6kkj7H2TMzqYL6gA5avlFPce0nHZgWkMUMTcZJUnVS1lNe82IWOIje4RUlOP3iS6Ex6F0qba044fYWhTGjhCBuVoiwstgl2hGsYUvXY2dnvVahNTAZvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=oPrcLuzK; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-356337f058aso3066837a91.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:48:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772027312; cv=none;
        d=google.com; s=arc-20240605;
        b=NndZ9tVc6ZsP8hkdW60EHMp9j+QJSmkEo5LUlXlF5T6zTsx5ZJ9Ako27nI8oPjwVF3
         6qbMZiugO1NqDhHke69lyNQ1grS+UOJI3o2UBywF+nOzgSnsrLfYxQqSSLP7yfC2YsRT
         rnCDyR1k9Gp4IAcn5P3cxJnYsZhrlO3bSwj4o/2dRn1rTiAjgOO9N21CRMyyPXl4uF5B
         8FxLx3Jg9Z8rdSZ+dpnKEZ14bps8EvMYN58jOTLJcD3WeO9gNGQ+i1XCpL5O82Esuvb6
         +Y999qRYaav4OshagjLqaAqsZ57GZoUIObYDyNDGtX7fT4US/7XhxVJdUsQaS0hm1f8B
         kqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SssUEHOHY/uF1odyg5G0fB8AX0zxj3pYD2qqdMBOJes=;
        fh=Wls+cvjdYtEyrQbuwxCXTTLhOGLyDxnWxmAnRBguiHE=;
        b=PSAsISDZjFKlA0jiThXF0PsRjE9i+ICckaaRc6fsN8Ll6Qz+qKnr+N5fg2/Y4SkzXA
         MBJtRzxy5vBMtbCK8iBD/CRSA/qCm2c8yN90y0sw5hjp1FaBSqtIHWCnITcRwfmkcCLH
         PmWSBRpj83qdRKRdlidcwqQcvLk4ZsukXL9ycslTg3vkrxuAVkyISp+9Tk2K1A6a6anC
         EAeNtEpulD0UBIk/8VdTy2Fv0viPjjcgOhHlCkYoai9BbxL+nyBDtCdEPGPow+QUUmod
         RsOssusbTRZSPOnGeOjGGAewk1XIcAW8x9ekIB3n0f8K5XSGpTDDvNoM00xE/YNYBKHq
         IKJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772027312; x=1772632112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SssUEHOHY/uF1odyg5G0fB8AX0zxj3pYD2qqdMBOJes=;
        b=oPrcLuzKRdh48hSTw0cQnSuv5ko+jy7XSL0AHUDwq55A0QnJiTZPjHx0N4hL9z936l
         qRIy2EgJd43Eq12ZKcKcNk6NG9dmAJpLExetfAZYtzZuPDiOk8XuA/0RQdumht5EjXiR
         hzimFR2Mz4jV51HTTDbngcw7VFEFzeooAvVVH7tjRRRECtTOrMDA1tDpyIy7BktFFYeA
         4mdLHpQfAzWUkkVeMui4tU4pzU0IrKWsQGdnXsBoITprJDW7Xq5u4DEIGHEPTYsZ8iL0
         tvl8v1pjxQHd7A2kIt29En+rrd1FRgaVpuSUJuTDfqIWnZuf1VA+1EFe84Xm3idHoKzY
         zWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772027312; x=1772632112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SssUEHOHY/uF1odyg5G0fB8AX0zxj3pYD2qqdMBOJes=;
        b=hokUBhky+dxfEHMe7Gv4mD/bKg230UZB29sdK7s21SesxRfDNZUZhlxY1hXEcmIu1u
         1+VYQD2kZTY/vVLhRkt2Ns8r4hJorgsSH0SNn9qnIYcp3PPLmhe5Si48DXn6wj1IsnyN
         Iy0Q/AVmquoWhs6FrnzFU9NC++0ZtFVGIQ8uEqY5jC3/O2LHiPihVOoIyqhGtTvxGZnD
         LhONNou3qtB3tKfBKDXbeEinGPFw2PubM2ZHfBrvd8d/5YNcXqtkKW8bgHUZTWc9XPlg
         9aIxnt75sMaTrOwGkrxIOcUnzqzkh7Hjo8N2ZqMHduonX5LrU/wSlHcDm6xjxuhzV4Vm
         GklQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+pVB3Nb6jUAke5tT1uQMcArRJdvLcwyL9B1YrA5BkpDsldbjFpPVtpHAg5HzbvAJ6bJGgi24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHK13v4lK3ICd9UitoiM45xL3fGaazKUWNGat+FDcUYyy6qLbu
	SyiQZIGCjmcuCtioMezeJRXRpKdR3NpRUpAhq14VrD8kBADEXZYcFlJrRvUi9upvK70YoFX+J91
	7VOaTT10A3HHmyfydQLzN3eEJqoMoRjkNomtcMvdW
X-Gm-Gg: ATEYQzyqPp+28povm9+7DPAZo8kYH2ZrspT+4Ekixgrq8WNo21DD3S3U2SMVXPgnrxx
	ZVsva4NVn/OvQ685V5dcWhp/4kG6iIvbaJd5R/ghsQXt+H6pAScmSe4qOLrhh3XQWbNO6bwue5o
	jYnC3xXOaCfFw9wLzv6+7VMdSIi6b5QjKdZ4gDrBQrSFeOksumQDKRzoEEcKBs0VAtxZn8b5FiN
	S8rJG6I9sc5TmoDNZCFuUpcRFm0j/lGPT4wNuVRLu45q4dTtHgG4BY6by5xtu2WWYfK3z4XLm3s
	tSOItYN2y3MRQfo=
X-Received: by 2002:a17:90b:2541:b0:354:bf10:e69e with SMTP id
 98e67ed59e1d1-358ae7fd8b1mr15571129a91.9.1772027311914; Wed, 25 Feb 2026
 05:48:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225134349.1287037-1-victor@mojatatu.com> <20260225134349.1287037-2-victor@mojatatu.com>
In-Reply-To: <20260225134349.1287037-2-victor@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 25 Feb 2026 08:48:20 -0500
X-Gm-Features: AaiRm526z78kb6pqwv5yjTnNLSTq-cnznJZR1oL_ql82KIDgESYV2mk0Horahpk
Message-ID: <CAM0EoM=Q0qFkXC8ZhAkZzKqfqPQWWBZwPjLc1QAp4KVprp5EJQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] selftests/tc-testing: Create tests to exercise
 act_ct binding restrictions
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org, taoliu828@163.com, 
	netdev@vger.kernel.org, pctammela@mojatatu.com, km.kim1503@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260963-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,163.com,vger.kernel.org,mojatatu.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: 49228198649
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 8:44=E2=80=AFAM Victor Nogueira <victor@mojatatu.co=
m> wrote:
>
> Add 4 test cases to exercise new act_ct binding restrictions:
>
> - Try to attach act_ct to an ets qdisc
> - Attach act_ct to an ingress qdisc
> - Attach act_ct to a clsact/egress qdisc
> - Attach act_ct to a shared block
>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

