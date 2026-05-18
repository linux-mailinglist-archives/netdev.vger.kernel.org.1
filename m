Return-Path: <netdev+bounces-289049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJrTFNoJC2o0/gQAu9opvQ
	(envelope-from <netdev+bounces-289049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:45:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C065356CEED
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CC093047991
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC2340C5CE;
	Mon, 18 May 2026 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgR68Jz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F3407581
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107612; cv=pass; b=rgeIY7Ju3AwndeF2FQANhqbRomU5f0Iuo8tMxfV1WY/sOfStpMvCzQhI0tJFVsPDnvmOeH8t58WavIH9xB9NjUW6nsmWBUGWq9fBwZ7Chj4ObcKuGuSgSR1qrVtm+Mctsgfzn5ZRsxdbD6PFeXtSEscPqm+xkj8ZX03U4kB4WVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107612; c=relaxed/simple;
	bh=Ifr64e2YJgWYjf1f0hHTBKtL2yHCYOwpPYPeoSBlCiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWdUrX6eJps6u9uy91PpmE5ME/0ukkVOIPfITT+aaCcq+93uuZ0faUjGc014KJdVkbS1pAKAkl+m4QTc8HbIvfAJ9nOYCVukK+JyFHRiaoDie/CPYTC/we0Ki+5I2FDJ+23J7IKLr60tLKC5K1jR/lqOvae/iNy+wG9flQgDnAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgR68Jz1; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so2924700e87.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:33:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779107609; cv=none;
        d=google.com; s=arc-20240605;
        b=TqmbHSc5LsrjOeA6Ksbm/uUN0H+8gV+9b9r+DdE+X+qTlOT61Ol1WfPRLVkHNXldZ7
         T2UXY5oY5EvO5scdX9TnXzFB0NlA6r2pt3VLI49uaU2a7UTTQzr52HNkO/OgLKjjUTiJ
         iaNYnNohQiJLNa/qhT3/GPdUdbl7vsvRFJdWQooC3VKjq3Z4B8B/gBiu4iM7rr5m7r4I
         w79gnR9qk9sDUfXbli+PbUP564QcXHjB0DaqAZPeaaUrV2Lt7qTEgtlVytAMlQV8+zuy
         gTuW9qLjCZjfHfTRInZN6HUnHl+V8Oyh5EBHON04LD2yrz4ITqtbmXgWjMD+usR7vpBr
         TrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NVEsgg5/subMf9Aiw+AjbNDpDrGt2FX5Fb3ebooqjrU=;
        fh=BIthyDv0sOO4tiD2e+vSBHpn4t10H9VV+njVllexP14=;
        b=LZ1zbZxNgA1MB6X+SoOj54Qr1Hm+yklVC0cSMVcmmnIM7PJi40cNbPoJDmix1VmfQC
         4zhsqAz4IvY8mdsjp0QjKlme4z4HicE2qgUNTxSlhoQ0AOBxNs7KuytoqiG0QDAMDLJr
         E+y2kjZ2LfU3SGdNHa90Oemr5c7vOBwM1S92sbfd/HXNJ5zOiqoCy03fHl+XTx77b3w1
         SXP3gt8BHIA7XAtctjf/KtAqU+k99JCOps5aLhyyafHzeWtot4uLQfl9MT0r+cQKKKWH
         haoXe0u2k+hZSldTqwu8UkQ7eDQ4sj6VolLIADZw2EteAlyYH88M9adX2k8kzMEK4U4n
         M2BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107609; x=1779712409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVEsgg5/subMf9Aiw+AjbNDpDrGt2FX5Fb3ebooqjrU=;
        b=fgR68Jz15H1MkHObu0Fxqj1UCzQ434bLKoNwnEdbiwlk7nGrMtSTBvV/8LZCi72aaU
         JCIPj3JuytdPrSM8mHYQFC0HPvc7f2tZJsbt7uw72alXeFhq/FDx+i3NXn6JxKvLodWB
         3EnfwNnssrHTCnd8QIJ8qKrSqT0C6k6zFj39l5FTwjnIQdfDw6hYzrS1lXv0bElN5Oro
         rpBVDuJ8F9Qyp/WDvsjRrGI7037vOSBxQHsLcTZJtaY9FzUZIj5/dKoPvpyjR+7cZUgW
         xec9x2CQ4hBIix+FcOLsHJJAJhUKFuJbzxVsLsYVN5qJfLb6vH8vMj0SUtTsN8R6whDO
         aFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107609; x=1779712409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NVEsgg5/subMf9Aiw+AjbNDpDrGt2FX5Fb3ebooqjrU=;
        b=UYRjLRxy3YIf6e7efcbWOkKp3FKsf4Z3azFezhlJel2qPBXxncFbD2vpwaPlBjEfCK
         3LpTnb5S+jrKycmfrBiSh5SWSz8ZSNlsFeVjOCrvmIzy67UD0BMEMnBJnD7mC7Wor1qW
         3xvViL8KgOZGiR8OYIAxTyb5iLs83te3blsoGPJ5jRU1YpFeUHjDY2oWtyor8nTgRmX2
         vOScXshMCfR8vRJwQraHI2jYCPPyUagS+ksTL4FcPsB7oCUXoXjyfAO4Lf1nYyYlkG5H
         9InrxIkXEbGIOUJATR+q+J+G4aNhfMlCG21xxfJC3HoRjWShRUGP4vVthm7BYOpRTqAD
         yQyw==
X-Forwarded-Encrypted: i=1; AFNElJ/CakixW4ztOFnXuDbQE/AQsPzY68th/fmRYd1qVa9dJ2XQ0UDSzvrN1Du2w+BPljgRSVzmJqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4UDwjimXVc9O2dZ7gN824pwAaiIe6TYzp70b1ul55h0qtc2n9
	GzgarsSfJ/+dnnkMJSzduY0YELNgxFhkR8WrxLKbRc5CtrbSFmOT3DRTJWfguYHf8G6J0l/OP9g
	Aj+f5XjpvDko90kzV8FuF3+O5wJhwLsA=
X-Gm-Gg: Acq92OH/XyTEBeUj41irpZrSuPpAb8BvAwuXaO1SyzcmSBC4XwqIXYw6AAyFrQAZlP0
	6Ll1Avfea5uEhdRAxJh3OobKIfRly0uefNkB/TBfck4oOy+T0/k4TRQtlo48RaxQci37o5CshHH
	Mj1IXkaMwkvnebxMjQsUko0a18aUdQUH/pXLBAr05WTNyWdFJRam0YrbPq0SUXlEBmo4JsgFm4h
	gACntoCizjXhGzVMA3MpGn5AWtcHV5G0oli8CYpj3zRQxiy1R3tzWi86Aq7uIjCDfoYySoVhtkv
	oT7ZNgwp68xQsrkf2yick4bmHu85WqQV385cZjdC
X-Received: by 2002:a05:6512:4025:b0:5aa:b6a:602c with SMTP id
 2adb3069b0e04-5aa0e0a96f5mr3681238e87.22.1779107608695; Mon, 18 May 2026
 05:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-1-kerneljasonxing@gmail.com> <928e935a-b7a2-4cab-bb1b-49c88f8dd612@kernel.org>
In-Reply-To: <928e935a-b7a2-4cab-bb1b-49c88f8dd612@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 18 May 2026 20:32:51 +0800
X-Gm-Features: AVHnY4LIRdQpP64IYHtign6WaETaDhU84lBOzglbA1oWqz8gOuUpcEZ4Yhzxxkc
Message-ID: <CAL+tcoDgWZ_jib+0iZgVNLbHA_=e5=TjfOrJFfQSyuyd0ucf5Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] bpf-timetamp: support rx side
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C065356CEED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289049-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org,tencent.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 7:46=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> On 18/05/2026 10.23, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
>
> You have a spelling mistake in the subject/title.
>
>   timetamp -> timestamp

Oh, right, sorry, this is not the first time I made this mistake...
missing 's'... :(

Thanks,
Jason

