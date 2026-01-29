Return-Path: <netdev+bounces-254915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Mx3O7XSe2nrIgIAu9opvQ
	(envelope-from <netdev+bounces-254915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:35:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D2B4D98
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7135305E0B9
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0769835CBC6;
	Thu, 29 Jan 2026 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="e0OPrNEY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76535CB84
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769722001; cv=pass; b=I9KV/Z42IvoKjslmAsXimce1iOwH5K3KSc6uyx1xM10+i6tCobVQiUcyBg1ExWQ9bR07rqp+PesSfcdg84RmdmrOf6+swNlNe1sR8hjgO9YPCfSQB7/8qcmGYcThKDds/6dfHw+vDYpJ5JqsQeZFaE0gPivvOoFWV9rciJMAaew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769722001; c=relaxed/simple;
	bh=5syiZjOyPhlAgAPiIobyD7MBiFgsSRMup7Uat93meOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQqm6gRN1S4NTtlWukfXHGFZ6ALNRLoPzqgISKe3BRhiIXa6qJhtscfnIEcxvUD/V4B070Fiqa9krzV3xB39LtoFKYrn4tM2syYTfHYOax9P80018QvXbCz8+DCp36Ckqfyjq3kFaIoSaH6qlQvFp/W6rmFZV4pWU+yBrESTpkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=e0OPrNEY; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35305538592so1196636a91.0
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:26:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769722000; cv=none;
        d=google.com; s=arc-20240605;
        b=WGKl0W0wlLV0CC8saLdG4UO64THd0OtYa10bqMGJXyzf0MbvfBJ5MoiY6F5zPR5i9o
         Dct2L48o3tbIyvPSZdt39QB1fQTNbzt2dSuch7TGBnWnn0VJ4e/6139smSt/ZXnfN71q
         rRwTH0egVWhVpdg84JbdwpOk3qDP5Me90p2R26EeiIhRa3f9O4OJ6aMaBUUListyrgP0
         54Zm0qJxYLFF7WYplcbauK5bOW3HqfkNGRzhnim/NgJQ7oV2Utkt575nPP5EyHZo6F1T
         pTML+wOzYgcQ55cVh11v4JbDBNXW7Z6H9SRP8Z0JzmfcIwiVYgNxvNwoQOwpwOBHPo5J
         ThIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0lNX7OqruIVLlr9nU9rKZjf/jRmzvHxHIjgJmCh4Qw4=;
        fh=regINl9GBtC1kHXgCMdxD2E2MEnCZNKTmBxVkHvnwXc=;
        b=jc6tbN4JkWIXzwlRxdoPdBLv0Hwm9/qf31Pgssy3p2EFBzQxIhdfzd96K8/VXddkIf
         AdTjxAz/0Jx93cQpbbGhu6wIPyi3WbHQmBlPJIhssPdGc8qWua4zwKfDhCwekDSnHCWO
         pUXAJbrRd/nkVzO2Wwegw/y/ppMhNvGmub5YNdtdYq9e7+Yj1yhbb66CjJzt35vEz9Xg
         d41m0bgtTqalWlv5dI5rH5TZ8XASs+Ucop2dsaRlBMbHrV8ryzMAFzc0BHIqTqQkqdV+
         6QiS3MKbE2xClvgG5JezTXFXulqjNfqX+v2hQtfyaZyhvJpGtcQSCUZ0nY9Q7q127ZlJ
         cGTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769722000; x=1770326800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lNX7OqruIVLlr9nU9rKZjf/jRmzvHxHIjgJmCh4Qw4=;
        b=e0OPrNEYKVf4KhD5c7rHgwUOhnoB1/HEVNXg2pJhAtliUAijjX25yYv9G59I46tAwu
         fQJH4laZMv7NlsVqePG1Mevd+TTqyE+DuPQTBbMsxKO+kBB7kW+MCIgwp4ZVVHLvSlaI
         JeoWVB9iDweaILpxnsMLpHfyLaOmFFwURPLM1Ou0tA7SnRojm5dFwkL2VVoIXCWHd31Z
         MGfXraycv/FzLBlmByLw3cl5EfD6v/6UXnUW4zZlT3J91S4TeARjQI6/Jp72ymQDFSsB
         mGCJHqauYD2ehcAUPJrekMWgYl8YELCgBpFRa406VLTFE1ObAqX9I2KdK9AuxAes373N
         eYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769722000; x=1770326800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0lNX7OqruIVLlr9nU9rKZjf/jRmzvHxHIjgJmCh4Qw4=;
        b=WaDNuA4JtLLUL9NKagXeypdjbvdr4hvPhnRYCYha1zfcC0LuQk92MdmTwonna3xrTS
         zhGU24MGlMmIgtN6p4QqEAmK+DfVUQgge7D/oJYcPA50CKi/SPLsWIJUSdZVzJRgBUvi
         w3T/NZ4SPYnTQifcBbYx1kkypUQBwlp3VZnT9rXQKYJAP0r+dojIQA75uUoP0ETKsDMA
         IHCXhS+3/NQeTGe6RhjGPXjU6vFwPSKzoWT7+Sx9/rG0iLScxHHcPyaAke4mgaaOB+DH
         qihPGmk75WvlhNvX8H9aASPMzZXrmoz75EpJ4lrDLl4nYm/TUZEy6T+O++OPhkRdqqCW
         14qA==
X-Forwarded-Encrypted: i=1; AJvYcCVKBPhu2SfiSD8w0SDhjxA9L8gm7wYgJaVCPF7bO3El84/x3UHyYoTFsaHwQwGfyzH3nzEFgFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2H26nTNtBSpnFGQJGGdY7OjRSHCHWsuel9aGZkoPnhlJ8Djoj
	nuwaBn61w5FKKIOF2YrbC3Dk2TVBZoHlIsUz029IiiLLZJ5DzsZtsEYHAHJfbs4op/Ctglj7dmi
	FcPswij80nHAydgP3zcdGrEWF/31bgwrkZvNcFr3L
X-Gm-Gg: AZuq6aIcCtcWoBsoBdkD2EbV6RsdOrGa2RE86QqL0AfYUpCOvrsddk4/tmH/y6V2AXE
	CLzP16UfOsQhjRmwce8bAk8PjXqptYZ8LcruUT1BOrDI7ss5RGg6buf1WtsDiEYoJKYtd5NgyCe
	ZNzu/1QvY6yiUFjAihO00lCSRmC1lBKKDlVQzVUEebeGowlsrwfLYvi3ZqzG8W1PEmEhBlqh43O
	nLcHztn6vXjvoziYd+H5GdQDQ47arCS1eLAaGyTTvTP3VFIUOQypTxJVnXAl0PPmrIV355221xn
	vWA=
X-Received: by 2002:a17:90b:3c49:b0:340:bfcd:6afa with SMTP id
 98e67ed59e1d1-3543b2dcea7mr697067a91.8.1769722000126; Thu, 29 Jan 2026
 13:26:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirffTyUrB=MkXjw8N-gEA0Qvr42mbUndybG0+6wyFdGiajw@mail.gmail.com>
 <CAM0EoMmVchdXPrmnFObON4kf3FOz2SbjFptRmqTev3GtkxWGvQ@mail.gmail.com>
In-Reply-To: <CAM0EoMmVchdXPrmnFObON4kf3FOz2SbjFptRmqTev3GtkxWGvQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 29 Jan 2026 16:26:29 -0500
X-Gm-Features: AZwV_QiR0KnMJB8Oha9oTXMyqgQhgqTEtZH4m_iWk09T23ThNfCk5xzPkCNIaLQ
Message-ID: <CAM0EoM=aO=giqVWOFD8A57Zw91wcC5N0arT9PNPjnq_MA43tsw@mail.gmail.com>
Subject: Re: [BUG] divide error in tabledist
To: GangMin Kim <km.kim1503@gmail.com>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, jiri@resnulli.us, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254915-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,resnulli.us,kernel.org,vger.kernel.org,redhat.com,networkplumber.org,gmail.com,googlegroups.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mojatatu.com:email,mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 254D2B4D98
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 8:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Jan 28, 2026 at 11:20=E2=80=AFPM GangMin Kim <km.kim1503@gmail.co=
m> wrote:
> >
> > Dear Linux kernel developers and maintainers,
> > Using a modified version of syzkaller, I identified a new bug and
> > refined the PoC, and the bug-related information is attached
> > below.Please let me know if you need any further information.
> >
>
> Thanks for the report. I will take a closer look later today.
>

Ah, this seems to be a known issue ;->
See:  https://lore.kernel.org/netdev/20251222061306.28902-1-ghandatmanas@gm=
ail.com/
We are still discussing what to do with that. The patch on that link
should work - try it out.

cheers,
jamal

