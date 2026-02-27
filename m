Return-Path: <netdev+bounces-261839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMbCJjydoWl8ugQAu9opvQ
	(envelope-from <netdev+bounces-261839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:33:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0E61B7BA2
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ABB630745FC
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 13:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D12258ED4;
	Fri, 27 Feb 2026 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="VZspAtsA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF823E34C
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198990; cv=pass; b=RZRC9t7KKx7p3owUhdt33QHI3lUi8WIVk0AhYn3HDkVomukxfs+rsX1AbGQFl7PkbT7FZWAX2kKC3GFNdTGde9qthGrvPexZ7hy4Xbv6WHOjgO9Px/6oRRJYWzPRr4QVaUE1XF4p43xvygq3rdtlkXepFp224xA8BaDscRY/HlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198990; c=relaxed/simple;
	bh=iGKebz7R0c4Rq9PoP0LqbuUmiYNHkJn56cg7vDblbXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRhK+0TIk4kFo0LDcKDQHy3v4+N5+lFUHXUU0z5gQBfa+vCg4UrxbLPC7Y4mIGxf8N2eq0vK49gpWG+TmGvkdw+UGF6+bmkIQOdBnlOTcQHV0rHYXCWiWn90L6DyQtFemjWDoGAmXSoCU/0EseMuMcvradD8ZiFevhicBQbFDIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=VZspAtsA; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad9fabd08so2070297d50.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 05:29:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772198988; cv=none;
        d=google.com; s=arc-20240605;
        b=CcAkwoY4gzVkfdHHq7WjHWrkmXs04aXPseUz7unDf6p1tQqyjYdDsEbjgoXpipitpQ
         djunbSxfItQynB/w8FCim/E6/2PVMgNKz4otfNUCJfgbvQ6EZ3NZn4EtnOpw13lHUg1Q
         mn4AuVQsM/pZZMUysLtY7HyPPXi08U+We+yV7GYhHidxqZEybPiJMfcLO7wf9LBLN11B
         BLAS+SLDskOAEONiZqUQVefnW+z5ncN/yfX41NzlXSpa/AtP8CySa1D1wk94ZM2qQDzn
         HuUVDU+YAKrp2shseR8EyXFheuKX2+XQ58s4IA5OVHRPiaNwSWvqMk8Iq+8h3cRMdRDx
         wMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iGKebz7R0c4Rq9PoP0LqbuUmiYNHkJn56cg7vDblbXA=;
        fh=B7bo+QstwfT9PXUlxdft3isJQxmUxRCWhxsY0fhnEEM=;
        b=HRPVlPduU5q41NnsLaVBkivPVtikm/mF8PGq0+aX5hnLH8b/b+w8ohrb8H5ynO9zqJ
         /Z/3JUmvYJUqEHg830bQO4/1jXmxi2Us6XJ10KfRc4XmyiYLcBFJ7LHhPy7l/+gkL9HG
         ntlP+Xq8FZSU/dwpVQpo8kI54h6CJC/u0WV9I1xvfyGuSwmTdrUVcbRc8wYTXL+XYGHW
         pAXB988KvSTdPdo5drXqPqJMs1knr7ArQkuRpn0139zaGo6mZrV0vvcesMkWXOlqXpMs
         b2BOqmDupUQjq8P602U+bxD30j4Y/T7crsKQo8z2jaU4I3e2G73T8vuIlKZRe4XHsBp9
         tIoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1772198988; x=1772803788; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iGKebz7R0c4Rq9PoP0LqbuUmiYNHkJn56cg7vDblbXA=;
        b=VZspAtsATpWTq7m7o+s0r7RcPuJaMhq5luBViWdeOE04wPKCXB+Cn9aejtaEcN2wdZ
         iNPvyqguRbR5kL7GxLkzOt3g9NXACLzfMkyGKSm1vP1YR+UdzLA8GPWOUxaZQrmSafAc
         XGq/Vw0AS4DKRe11eN6oJD2euN6auIDBtdG3lqh4BJ+w7V8dxxXzZ6S8TR1RI/60OU8O
         GFHAcToSNidQAA4RKbACdZGHg/upwKNwEUhO8i8+WRXG4Xni5p41ypaNHTLcXExAHXlm
         lP7g1UL/ijTvbj82GLHfaRFC5COub+gRaNfbEJ5vCG9n+MkrLnqBPrkdw2+FxpX8Umqh
         itYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772198988; x=1772803788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGKebz7R0c4Rq9PoP0LqbuUmiYNHkJn56cg7vDblbXA=;
        b=jAGe9FP1/MoQewC2C6xiQIDZ43NEzUidFSiMvkH9GA0g3S2MVSGTBIeIZgXmiApCxq
         OR4aCGF7XpiczDWC9upZ93Bx2yfmAOODuz786R8vUa5bS/pNHW9wzhw3OK/HJUSVGWfg
         p8pQDLB2dRo/0jGAFGeO/fsbNhTwidZqTW+bIZsmKQlRC3lKNw6haAIiS+wt32VSt41v
         kvWiNq9Y4rROzru+r2B3ACBtBAx4M2Z13w/AUkJ0wiXc2zuAI68A+SpQJoy0PJSUHcu0
         +Wll2BzjhRILHLzaM+yd6Xkqlx7SkUYk3z9aZftPS0N5p6FZV3x7DVl0GDQCc6+P6Sc9
         41zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVYzXmSHl380la7EtAR9+5+xP3n2hZ17jNA78aqUK1+P+exBgS7qhuZOX0u631+snfbKPEhEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrzFceCDkucgryKXRwgzx2Em8ASSOTHW55J5vFveuC1MGT+o0Y
	KThtBnn10MCeXusNhxIEKefjqJwBm5as2JhUqlR/lmkneFIT+kcGOOR87IXCx4HOIKCsgkC+BlS
	WxuDX/LbbUgqC5b4hWCJT9B1MI6obimVMhqZhMsVo
X-Gm-Gg: ATEYQzzYiaWHqUkp8ahOub6e5HOUgvIvkz8/9/zQQW4eZmccunMCdc8c4+uOBNdftT5
	GxH4P2TX7vFE+xK+fgOUXq1OwLzmV43EiILQtb2YUsL7ocAR3fBPXG6coW9LpAnWwgtnG1NitIx
	81Jx2lNEg0EomRd98XAeVgjZ5uKvt6H1mLv48tDqS8h7K7UEvxHz4E6ISE4URnhEUBbFMce+G+j
	egMynHRtw9mctrXvA6ur5qcv3N52yw57kUIFTNWxx+NpScxCReX8h61wv7Ied5q3ow0NG19BEo7
	b6KjvGFMpyy6fgn6TYd4Zr2WYpP6WzRA
X-Received: by 2002:a05:690e:2060:b0:64c:a1b9:ff8e with SMTP id
 956f58d0204a3-64cc2025a17mr1867109d50.15.1772198988446; Fri, 27 Feb 2026
 05:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223150512.2251594-1-p@1g4.org> <20260223150512.2251594-2-p@1g4.org>
In-Reply-To: <20260223150512.2251594-2-p@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Fri, 27 Feb 2026 10:29:37 -0300
X-Gm-Features: AaiRm532xdPQGIE3xPApIpgRqEq3CFinlPLHTSQm8jaoRnx_ggMxrqHvO3ahzPo
Message-ID: <CA+NMeC-PZGQo1JCPj60Ah=Oh9ZSDv-ZD5JSH0nD3+H_LVuZqpQ@mail.gmail.com>
Subject: Re: [PATCH net v8 1/1] net/sched: act_gate: snapshot parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261839-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:email]
X-Rspamd-Queue-Id: AE0E61B7BA2
X-Rspamd-Action: no action

> The gate action can be replaced while the hrtimer callback or dump path is
> walking the schedule list.
>
> Convert the parameters to an RCU-protected snapshot and swap updates under
> tcf_lock, freeing the previous snapshot via call_rcu(). When REPLACE omits
> the entry list, preserve the existing schedule so the effective state is
> unchanged.
>
> Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

