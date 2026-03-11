Return-Path: <netdev+bounces-266654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMQtFfNxsWlVvAIAu9opvQ
	(envelope-from <netdev+bounces-266654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:45:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88276264C69
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D4FB301C15B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B432BE05F;
	Wed, 11 Mar 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byWkkAit"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6ED258EC2
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236462; cv=none; b=Y4pWBoTtfMVRJksrInYGx0asFMeLsKo0auJdAhkminGpTfvC8mkBgOwnK7OVdzesi68LJ4jYU/OTANIYgzQueJYsn2h6JlFsUjZXin5Ury9mYSaQCAxFxG96x2gIgd18ouc4kVArR9pRIJTg+JurekdfloTXlJjkfh06W72NTpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236462; c=relaxed/simple;
	bh=zH+nZAS/0TC3vmmnnaXhEA1DY4B7bJRN03Os/2+v8Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mArS+YuP+yJZHyfqQg05AhHEjlHIVwzCE+9DtCVP+F9Pi0ckJd5vHFC3FUjknJVYeO68uewVQyhQKAk7Lc1IKzypp1TWGAjrzOJV4rTUAPMLDWHv+CgFZ0L5gHpQAxKEcmW/N4mMWFj00VwVdEVotdCM+ZwqAv+q3V9QA2dIYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byWkkAit; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c2af7d09533so9136646a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773236460; x=1773841260; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dthsm9IgXWrH9vxEL44Vq1RUbuK9+Yq6fCQD2GB7TU0=;
        b=byWkkAitSzPry37IdXR9Io2kfw41ywGzVr7OIJAGNwGeBqd82jnPMeLIdh36IVGFlP
         uB0B+tuYu2jWOKRW07dUr1QB/I920h9lBeso1EKSqm7Gz1G8DARFptcjzEYfGeavEStY
         oujuTHRsuw6UhOLOFUOsJ88DhI942G27IKVkQdAIksHo/Ebqc0OFyRjgjnppB22TRzyF
         F+F6zYcekCbpn3Z/fawOfALOvQj5b1EIn/FTi3p6xhaZ4pjR8iPAU1PqGZdfGjCvXGFJ
         hsB3agjMkJ2DxBsEBWgPQHOBwMkfgre/Wep4LBtEVb8epWvhyCeQ3eF4Vf2eL2+YL9XG
         FP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773236460; x=1773841260;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dthsm9IgXWrH9vxEL44Vq1RUbuK9+Yq6fCQD2GB7TU0=;
        b=DWkLMJcX1WNUSMMLdJW+dRwCr6RIskbajDpWEohcDFCCUOePAFOF1GQa0Yom7iEHVZ
         XWM7WXBfDm05dHlKBbzY2vQeFLP0oT2j/PpOxCyVivNrssU72wfUl5Bpu96Sd0g/No1l
         yZhhKKx4FKJ58YoG+1BfPHDA+DNuCH2FPKaS5LnHQ1wig3e53H55M9hS1QZK7ObBhdHE
         mErnpIx2nzVEQz1aH5l+Ve/OmRGrY1XNQF0C8klLCTrh+6powqG3XbCtxA00i2Yy0e12
         QNX7ZoV+xjzvFlqL7CiYkJBJf26NQSWlbeeId0utbvzeQlVnFnWgD/rM6cdv5oU4HVqS
         YpqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzpQLzopIY2d1XLY4tUhU1fp+Lb9KdjWQxMl7HlEG3QPcVyVXeFTq6kRR8X5V3qGzVGiyw3EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMkqj37cPp4S71+ulHsbzHSocn8Mjb9Xfg7IOm7ESkcetq1+Lq
	wexSk5NDbL6LQAKvAaCDAMqNBr27UCfpCrzTwX3h5JIPa7zjcKCFavvd
X-Gm-Gg: ATEYQzytgtqJl/n+yjxeaiu5bj+572W9Nu5A73QwxNH1XCbuuSC3pVQbxC3fAP0rtJG
	+PMjGgyTYGSYW7fwBkUB43XgJNDgeOjvJ5zD9Nl5kDkp6wFWLXTJ15iznb8K7z4tIRnkS6jbvgk
	7PS0jOCMrlDKilORoASmw0995ppQTqBj2XyuRMAgc9Edg3ANWbKb22tuFJunID7A5EOCioNCaml
	Kpi360iYXwdKvqqBrbFXYa2LScgZclUlnYTTidIPErEo7/929gENUQm3B1XhIAZXl7oET0bpuXy
	CBWwXIgx2dqkKDWgc+FiGCTgpwKdXFrqQIBMBtFr93Pfb3/+NRIdDX4yiq2BDLO9hJ0YqrNYty5
	qYscnx20hgFMI2tEgBNPn02qW9Q4E/LZGWLJL5RuFOFWg+jiMdFYAzI7RiQ6hnqtz4pDICFDqNt
	Y4HOgufWxwC3BtX95jUzBtxmG79pr3B9UR095E8wTt9w==
X-Received: by 2002:a17:902:d50e:b0:2ae:4d97:3012 with SMTP id d9443c01a7336-2aeae8e4e80mr30935955ad.49.1773236460199;
        Wed, 11 Mar 2026 06:41:00 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae34e009sm24371015ad.46.2026.03.11.06.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 06:40:59 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:40:51 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eyal Birger <eyal.birger@gmail.com>, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] xfrm: Fix work re-schedule after cancel in
 xfrm_nat_keepalive_net_fini()
Message-ID: <abFw43p05SDqfQ-M@v4bel>
References: <abBf_R81PYmafhWv@v4bel>
 <abCh2CgVS3Uw7W-_@krikkit>
 <CAHsH6GtYpoowPJe5VWMcm=CCdUernc1q-Sk6HznXxMy7LDAmrQ@mail.gmail.com>
 <abE1Q7BMvZ1l14jF@krikkit>
 <CAHsH6GtCAqJf1PTGjQppScME6h-dXCUFJMeJvmJsrSDkhSJa8g@mail.gmail.com>
 <abFty6McRkN8dtEe@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abFty6McRkN8dtEe@krikkit>
X-Rspamd-Queue-Id: 88276264C69
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266654-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 02:27:39PM +0100, Sabrina Dubroca wrote:
> 2026-03-11, 06:00:03 -0700, Eyal Birger wrote:
> > On Wed, Mar 11, 2026 at 2:26 AM Sabrina Dubroca <sd@queasysnail.net> wrote:
> > >
> > > 2026-03-10, 17:14:19 -0700, Eyal Birger wrote:
> > > > Hi,
> > > >
> > > > On Tue, Mar 10, 2026 at 3:57 PM Sabrina Dubroca <sd@queasysnail.net> wrote:
> > > > >
> > > > > Please also CC the author, and maybe additional contributors, of the
> > > > > patch that introduced the problem you're fixing.
> > > > >
> > > > > 2026-03-11, 03:16:29 +0900, Hyunwoo Kim wrote:
> > > > > > After cancel_delayed_work_sync() is called from
> > > > > > xfrm_nat_keepalive_net_fini(), xfrm_state_fini() flushes remaining
> > > > > > states via __xfrm_state_delete(), which calls
> > > > > > xfrm_nat_keepalive_state_updated() to re-schedule nat_keepalive_work.
> > > > >
> > > > > Eyal, I'm wondering why __xfrm_state_delete() calls
> > > > > xfrm_nat_keepalive_state_updated(). At this point the state has been
> > > > > removed from the walk list so nat_keepalive_work() won't do
> > > > > anything. Am I missing something?
> > > >
> > > > I don't remember for sure, but I think the idea was to have the work
> > > > run "now" so that when deleting the last nat-keepalive state it
> > > > won't run in the future, and in general to refresh the interval and
> > > > not wait for the next iteration.
> > > >
> > > > Eyal.
> > >
> > > Ok. I thought about this, but I'm not seeing the benefit of doing
> > > that. Assuming we're deleting just this one state, the next run will
> > > process all the remaining states in the same way, whether it happens
> > > right now or at the previously scheduled time:
> > >
> > >  - if the next run was needed by the peer we're deleting, not much
> > >    changes except that we're recomputing the delay earlier than
> > >    otherwise (right now instead of when deleted_state's interval runs
> > >    out)
> > >
> > >  - if some other state was the first to need a keepalive, we do a run
> > >    for nothing
> > >
> > > So I think we could drop the xfrm_nat_keepalive_state_updated call
> > > from __xfrm_state_delete.
> > 
> > Right. I think at the time I didn't think it was "nice" to have the
> > work running long after all states have been deleted, and also it
> > decoupled the implementation a little - i.e. if instead of a global
> > work we had per-state timers (which one of the original versions had).
> 
> Ok, I see. Thanks.
> 
> > > @Hyunwoo here again I'm not opposed to s/cancel/disable/, it makes
> > > sense to use disable_ in a "destruct" operation where we don't plan to
> > > need the work again. But AFAICT this schedule_delayed_work isn't
> > > really useful.
> > 
> > I'm fine with both approaches.
> 
> Ok, so:
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> Hyunwoo, if you want to send a v2 that does disable_ + remove the
> xfrm_nat_keepalive_state_updated call, or keep this one as-is (and
> then we can remove the unnecessary xfrm_nat_keepalive_state_updated
> call in -next later), that's ok for me either way. Thanks.

Thank you for the review, Sabrina. I'll keep the current patch as-is for now.

> 
> 
> BTW, patches for "NETWORKING [IPSEC]" should be tagged as [PATCH ipsec]
> or [PATCH ipsec-next] rather than [PATCH net] or [PATCH net-next].
> They go through Steffen Klassert's ipsec/ipsec-next trees, and get
> pulled into net/net-next a bit later.

Got it, will keep that in mind for future submissions.


Best regards,
Hyunwoo Kim

