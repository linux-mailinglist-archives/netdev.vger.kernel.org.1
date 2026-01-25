Return-Path: <netdev+bounces-253140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGnIEuLEdWkKIgEAu9opvQ
	(envelope-from <netdev+bounces-253140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 08:23:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC547FF87
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 08:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E15C3006B34
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 07:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434517DFE7;
	Sun, 25 Jan 2026 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMtoP8jD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989233EBF02
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769325790; cv=pass; b=DEqHbVy2eK3X359IaSDvxug5vNqkqxsGj7DyXoNuMLK2nqtsIGw+v6Ujoz9NSqzOP/nm7lAdsc7a+EKxgq/p/dSLjL/jq70KI+7/G4+ye7FXbtSduJ8FkM0gFDiQRx02ihpD9wK3vd6Z2z44srCPkkHkLnyDuZRXjAvvZyLXuHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769325790; c=relaxed/simple;
	bh=VnApMyBb5Lrx1NQXfbHpHD+Twa9Dd6+LTVVahn43QiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMHBqdj/Y+yYqScjidv7F2su/JTtiP8GfIFQOkKPCV47rFRyCSvNhw5AhX+XzPraOuGk0tnavCc8DQ9OR+Lln4qczFVjsHFPYs8BPCQAhfiSUe5noIg2Hbwzkto5w4jVIhJ3WPrNpbc8nhj7eMdjgOhCBheEGM9qsjoo7K53800=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMtoP8jD; arc=pass smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-894676e6863so42034516d6.2
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 23:23:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769325788; cv=none;
        d=google.com; s=arc-20240605;
        b=RWHQNCsk0g0oBTs0oU8X6bPKYkAts2PDUVm3PDKWXCb4W2c3uJU93aSoxbFp7mOLvO
         rtU+HkAbC2v1OTBWD4K7jLGXX0h+u9uF6fkRzUvWB/NTg/WAdcImYCotG9N+4wYZQVhH
         ssqd1nphlOYpRpD7ifhOaLQ88b0RpYhtHI9RJ2uWGWipTsIb4kWOSMxkXpEBNZpLiqHR
         y1m5V+zvyWMfSsPsgt3sBXtqxBlhpPnP3QC9jFcZbGA9Bn1cbst9u0TCcWHnAen0TXSb
         yvPNTCbZJttNsH679LSQm6N1oks7iK7osh1GrmSVvu9E7ZUHEuBNfneLklKpXJ+O0Iof
         q3WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VnApMyBb5Lrx1NQXfbHpHD+Twa9Dd6+LTVVahn43QiA=;
        fh=RRlwol9IQiXgvycvgILVzd657V2Kxx8b67WQNNEoNvQ=;
        b=cwDYLp9/EzQmZU2m1vagoT7Bf/SMK55l5H8fELeSYkndVDlUu027vPy3FFdNPwM22O
         bTSTy3oaxibCjrqSodt1VYn0T2Ar87/lrbHCk2h8GnQz4ZuxEwEleUljDzOx7NWFS72a
         68Nfglomn3OE+9yl1K3p71RUxQn6s7mOTeURwWHX49oZRgOaG2FhFFPz0wEclZdm5IQ+
         mSrLw33IzMtiZ1Jfv3CNlUmK3NTD4eVhpw1inlAOSxUjs95sD3NJLknHzEhPYdXiwO5N
         42C5bUu23OLBvR0bDvIz+kY9wBbCFQO9LBTbu5kf/OmbzP1f3rMb6ojFBNTC+7jYHg3t
         mLaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769325788; x=1769930588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnApMyBb5Lrx1NQXfbHpHD+Twa9Dd6+LTVVahn43QiA=;
        b=MMtoP8jDMYMA1A9rcWd+bOKuH3FX9hlavPt9NUEcoet1gVKy45Gjj8nbI+7rvHraYX
         kmDWHhv5DZ6inGhQSVGUB+7YfMQIeriVijQprAanrnQ5xvxDF79Zpl9bX/jhfPE+j+Cl
         upaNB8YKPZMhNLNSoh7H8EivhKl3J3pyb6g4oL/ieDpMMl7rBAg2XhFO7HTrlDpEEnMw
         gVJ9UxrjjLjpHvRxRUloIAEV8Ngg4FHjpBmA3T1kEfqxPA9BNY2tNMsBnB7jkIt6LHyM
         b9bMCY4Tk54HXUtamMljyUgd8aSnM8xgYIE+uVsJ8MDicT9QMF+3+GtSruR2AsvxvbPl
         P39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769325788; x=1769930588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VnApMyBb5Lrx1NQXfbHpHD+Twa9Dd6+LTVVahn43QiA=;
        b=WVvXLeDSgZBWQijVRP+Y07xAvHuc06A66+VGUEpFecSzshNBvvFdUleLIsPuIh4RCL
         9+62TcE1ly6FjS8Hq1pRdG2wEEkgJ0lZlbHQiYNG6gd71FPt2VHk2t/TPOV4HzxCf1zt
         VNBbKdHZCjJ20peqg551RHDAV01MH1Jl8gazQd3ipnYdV6S0NJds/NblWzPV/Yhi9YXQ
         d/br0bbQOmxY+cR7utDq0JeqGjDOiGpzrvDhibHyMBlmMgkzHRjKphAGS3wxdJer0uVK
         CyWvDKShsS/F6ip3L86cD96xODmEP4MyiYcOXhX3UrfsRu+AtgAcwkgkDgFnJrgCpcEz
         YRag==
X-Gm-Message-State: AOJu0YwJPFrWsATsceMS6GMB4pupvhpKapt52OK60tIzr8v1LqTdCL3C
	AQsd84/kJygzcC3IiEM5fY9E2RT6OMeyfUkgvHLnz6fEgVQ0Ie/z9w4rTv5McKex58B2/U7nVxM
	Rc9mgfHoOTJmN8GKTkdX7VmBxWMR5E1KqFWVQ
X-Gm-Gg: AZuq6aKFQi/H8dcOWtlwDD84SVDf0nzDZdakNGLSM2QwYctx/kEDmBUijYjkflw2hoW
	M5geT/E7m7rIt5Gt7RprdfRc8wXAV6xjjag6p1hFvu4Y2VSbZpND/AjlqCiiDvm9JMhc/+knH5V
	yBCuUGI9Rbr7sTeKLeHZyYefZnboqEE5H0OL+g6IIumWESvJCA/y3CLnTsdCzXy+BiTUq2m7ho2
	nRmIViJ22DP8Yu9Qui7Y7owqTVcc35ONMGd1VLdD324VPVx6VzIvGeiUk26sjX29VCNDJzlTHBU
	jdDx6VBcr9zVbYhrIPHlcMyn+le1vgda31IxRA7xq8M7lIgrJWgmF3Lj
X-Received: by 2002:a05:6214:b68:b0:894:773a:4581 with SMTP id
 6a1803df08f44-894b07d27femr11028416d6.49.1769325788112; Sat, 24 Jan 2026
 23:23:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107071831.32895-1-enelsonmoore@gmail.com> <20260115222954.248e9f79@pumpkin>
In-Reply-To: <20260115222954.248e9f79@pumpkin>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 24 Jan 2026 23:22:57 -0800
X-Gm-Features: AZwV_QhMPJXuuRqQg7-h46HrvHO4Oo6mU9bQfU7vB-yVfmAPNyyUc3cg-eeGVAg
Message-ID: <CADkSEUiQnVxWiH-u5atJQ05P88xXqA-AJAx-WAM2v7mLf=w2FQ@mail.gmail.com>
Subject: Re: [PATCH net-next] pcnet32: remove VLB support
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-253140-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6BC547FF87
X-Rspamd-Action: no action

On Thu, Jan 15, 2026 at 2:29=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
> One bit you might disable is the probe_vlbus() code.
> You really never want that sort of probe code, it can have a disastrous
> effect on other hardware at the address being probed.
I agree; my patch already removes that code.

