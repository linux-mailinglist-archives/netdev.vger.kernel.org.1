Return-Path: <netdev+bounces-271446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD07HySVw2ncrgQAu9opvQ
	(envelope-from <netdev+bounces-271446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:56:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEBE320F51
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 08:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19BAB3009B0E
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9403D394498;
	Wed, 25 Mar 2026 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dc1H2Igt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1AD3914EF
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 07:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425222; cv=none; b=FrApJX85N+pHm86SLJthQUFigZuIi8u03TBx89bx40RenOPNZZsw/NPRMwUxdfiDHW+x5lj/PToFwFmb6bT1Zw2gScsEpGxfrDfs6wa3komGHm47BUDXDF0En+xfhCt/xIYTWB75isisshgIRBbrFY3egchWy4SUMTkH7vG26lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425222; c=relaxed/simple;
	bh=vN6wBNcg/E0LachmQR04aY7jqJNSwiOry0TOcZc/IzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+MWBtnIVoNDKj/YdsQiLxxCJuzusDCysE7SxM4aWua1xVO0dzmY9YWaZPCLBDS3Ey6N0tVWv1AsD9Yte0D12P/XlHpink3PzntPljdqZM4r6DFwLtGcJ7CxSmRgPiyF2PXyoZMXoi65vudAO+psXDtV0qcIgNd0HXJ4wGknpIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dc1H2Igt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso5002468f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774425214; x=1775030014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4aJhflvosA4YHh4ObVTuB21z7sXs0KVGarenqaPCOk=;
        b=dc1H2Igts97blVG67otKMcPlM7Xav/nrcxFnNzWjy46DSlxplYgNMl5vgFVnRSWvfK
         HYN9K86QzFNUyhHCqxI14YEb26K7jREHD++kbM44/6idvSKfP/PXbdJ/Rtb39uLnW2Nf
         WIB78EiP36ka/2/Jbfnt1trbzADatAtnf0PBItqrxJDP1yGDizTu+39SqMBOSqsqrC9i
         aGwUuCvTlxucUf+5UgStghr+oMwifXX6/nYRswAwb0ok1+FRj700KOhEj1Vn3Y7bt8mO
         6PqPKlTcnxt6Uj00iNLbB7qSzto0nM1PmLmPO1WqawfiYTXv7EwJPWraFOIBJFqf7bvf
         aIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774425214; x=1775030014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4aJhflvosA4YHh4ObVTuB21z7sXs0KVGarenqaPCOk=;
        b=GHC6GhPSIgIMTTrpmtTGyl+3f4MGV9O/MtVJLwBB70jNv+SfEfS7b2RrAbPkKWkj5Y
         cyu9V7mqlWNZdEwu+U81EaEP8lHYw/6+QQToUyS/R/KP6T0M2obVeu2eeLLilR+TTxiy
         1+V6JQa59to8BorZD0zGyFV2JiZjUyiKnzR4NZ6qovowKxgf5mUfo4sb5U17CUzMhK9O
         biCLQE0LwNvcVb/4iPtTaiAYVcWM5ASEMOKU8kWwgRu/rKgM7d1EuPigZLnPJcDJz6nr
         2haRZM1lxRa8/pH/mGe6qi80XO6bxcxQ57sJhd/usAPYaaLTapobMDQ+9+7FCMC28hoi
         tDDQ==
X-Gm-Message-State: AOJu0Yy33/u/9D56vnMFN/xBqR7/Zb56gmXXOlc6QjnMg2TapSg3w5cZ
	wL2CHd3084Fjm2xSOXp3lLRPZsWhjpQE2GxqlQP0i3ZFOYVjSbWlJc55
X-Gm-Gg: ATEYQzycf2PZa4Oso8RxcqinqPczAgxeeKTOyjELbzd7STVrK43MOFnHPTcz72njZWK
	vx9etmeN4WRmNl2fkIIN9Ems75D9y/vFjE9ynXhykIOTdUN7w6SVKTMn0sOVABembZVt+aP/KEW
	G5bNtZgaIF03UZpSUOr0QyCi66hinClMApNVLOhEc0tdrD2XoxnIdaypEl8mpuIPol8IcVXrFkY
	uXTO7oZx8F78dq3zs4FizGjgJ88fWbrdJ5iEPadj4c7wI4goMSUPbqiTQWJifFl+HjpDzy9iZYa
	S95GAwJRt8A3DqHETM5TgoVoelH+DmlUqsNQ512Rl6cE7dWjWpRhiUmXgy8NLtzkIuv6dXqPj0f
	dtGg4gX6iXMDZTym6E2HzBry/2PL8GupGaRvHx2i22qMe7rdlTn7qtl5JCkg+xHi2YhjkRaSTR9
	lB9x+aPTxdpPcYpjmz6Vm4AydaAyrf2V4o3sC6kPVyft7IOPb5yDO6d6EKDSTNiWmja1md2pVH
X-Received: by 2002:a05:6000:18a3:b0:43b:490a:db51 with SMTP id ffacd0b85a97d-43b889c10d7mr3337506f8f.24.1774425213859;
        Wed, 25 Mar 2026 00:53:33 -0700 (PDT)
Received: from gandalf.schnuecks.de (p5b2e2f9c.dip0.t-ipconnect.de. [91.46.47.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b646b0d3dsm43087713f8f.16.2026.03.25.00.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 00:53:33 -0700 (PDT)
Received: by gandalf.schnuecks.de (Postfix, from userid 500)
	id EB824305DD2F; Wed, 25 Mar 2026 08:53:32 +0100 (CET)
Date: Wed, 25 Mar 2026 08:53:32 +0100
From: Simon Baatz <gmbnomis@gmail.com>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] selftests: packetdrill: cover scaled
 rwnd quantization slack
Message-ID: <acOUfG2NwQOzq9zR@gandalf.schnuecks.de>
References: <20260324205301.1361608-1-atwellwea@gmail.com>
 <20260324205301.1361608-4-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324205301.1361608-4-atwellwea@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271446-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gmbnomis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFEBE320F51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Wesley,

On Tue, Mar 24, 2026 at 02:53:01PM -0600, Wesley Atwell wrote:
> Add a packetdrill reproducer for the free_space-limited scaled
> no-shrink quantization case.
> 
> Grow rcv_ssthresh with in-order data, then queue tiny OOO skbs so
> receive memory drives raw free_space just below rcv_ssthresh without
> advancing rcv_nxt. The final ACK reaches the case where raw free_space
> sits just above 84 scaled units while rcv_ssthresh stays slightly
> larger.

While this may be the intended behavior, this test case does not
actually demonstrate this:

After the second in-order packet rcv_nxt == rcv_wup == 11024 and
rcv_wnd is 84*1024 (with your patch).  Even if __tcp_select_window()
returns smaller values as more and more OOO packets get queued, the
externally visible advertised window can't go below 84, as the
advertised window can't shrink (as you point out in your cover
letter).
 
> Old code rounds that final free_space value up and advertises 85. With
> the fix, the ACK stays at 84.

The old code is consistent as well, it simply uses 85 throughout:

   ...
   +0 < P. 19024:19025(1) ack 1 win 257
   * > .  1:1(0) ack 11024 win 85

// The last tiny OOO skb pushes raw free_space just below rcv_ssthresh
// without crossing the next lower scaled unit.
   +0 < P. 20024:20025(1) ack 1 win 257
   * > .  1:1(0) ack 11024 win 85

So, like the v1 version, this test demonstrates that the offered
window differs when constrained by rcv_ssthresh (old: 83, 85, 85,
... ; new: 82, 84, 84, ...).  But as this window cannot
shrink, OOO packets will not cause the peer-visible window to change
in this scenario (for either the old or the new code).
 
- Simon
-- 
Simon Baatz <gmbnomis@gmail.com>

