Return-Path: <netdev+bounces-282063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPRpE34V8WkcdAEAu9opvQ
	(envelope-from <netdev+bounces-282063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:15:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAEB48B951
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42AE8303EFC6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55F313277;
	Tue, 28 Apr 2026 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlhTZCEL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CB2E62D9
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407354; cv=pass; b=JcLHc0CrPvDGcADcvHV8/VkKufWWN8bmShmFL/HRPtFKF0fOMfI00E+sklIgskDm0GPupGTfH+lOXbYJ4wr1WSnY3mcokkw0F8XGmR03Jp73Z7J77IEb3hvtps4KcLwhVTX0F0VcXmpa+6BrcJoZXPywTocZ/OGiB+DzJTAYbms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407354; c=relaxed/simple;
	bh=jubsY6PGHnTXGhA5KKyDi/LWS9PbjTsPha5xbgCuu/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcjcT6rr2t5oltJf5MBanZGTM+8puySF1Nora7X8u/Jt6IlU2oMecEHGCajrIDWl16RJjGWVhlmyayMnLa9Snh90On0TdmWUHRiRtgBHypMzMkj+wz7iRIK7Yk8oeKqMtRm8Bz+XHiPuaHBNNYAfHB2i7GFIkSTiXeECFlvCvok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlhTZCEL; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c795f096fa5so4671611a12.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777407353; cv=none;
        d=google.com; s=arc-20240605;
        b=UjoamGob5Dijh7aiy3mw6RZPUhsSeruPb3B3Va6YG+iB+khnVe02hvuM5nUqp3ObGw
         DXwuesukw+3V+Z0XpFQLuvX+z+ayRufcdGsfRwlfviWGj/2VCjQ56oFMkcWS8dQnSYev
         AeoI/aRWu8lcu25R4De6mGvlSGJUCqatAHIfA6wvyAFjK2Qbzk7m/bCSH1tPiqlBwuiW
         ekjdHgg+oy/R5CySNzDJnbnx7j3dAnr6nPsYfAGMY89i1MxEPswizv7KnZtkOwE7AoGm
         cox74Vx5SdhfNnKCQ/fimgxWOhNAv6DXssZ0HdU7oIVSlq1RS3zMHcxymZQXrrzKyDaP
         0r0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uQV+ZUo0kltumkkS/38YnBQvpZ5Ru0K+aNTeRpdyz74=;
        fh=CdWhJh0s9Y46zmTSEuMX3wHnoe0TR5j5iR2YOdFtK44=;
        b=OfVJcDPGnBzdMbvSo3fKOmKIQDLCFTUf01OyyNDb8aOx7IBJ5WdZ3P1xNzqQQjJcXs
         oh7aR3PNeWSdGo5kSdLclrgFwlbt1WJ+NJorYRcUsYia+FsewGVMeL7+mAXjN4YsyWP6
         Zr8dXO8DYsyhURtPDC8EbaKnTqj6CFELI7NtVaV5B2aWf5RlR9yM5I2bGuk2i68MqPS6
         rIbun5F52gknAGoODuXOBVlt5r9Yzbm9Bke3TI5yQSJdU/Ry9j0sqAEg6OkHrHkEaz9G
         5pUpBR5vfUrV3OGbZLePLo4ChHZfeZkUcbTmRMHwRN0KY/dAAAJk0wgrYPlQTuV2XCg8
         oH/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777407353; x=1778012153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQV+ZUo0kltumkkS/38YnBQvpZ5Ru0K+aNTeRpdyz74=;
        b=KlhTZCELSkeBlc2IBRjM/spYNSJcZEx+XzogZUf8EXFJF3JgePK7hmDvz5NuTFJiJv
         0BK3ai6GXs6Ba5FV/d4g1cdK/BL6ls/W71AfgslX1RqhbkmZGwqATBsS3wGqmGeH6nb/
         xNU61DVSE4tbJYhfIKjDVbPYfQHKGcxwSbWUEqeSX2GlYVe7n1TWGmwLyTSdTy2lzZnj
         VNdG2g0+RgBVVsWPCECBHC8P2dK1ajWkNZH/0ZwWaclyCSZEiTKU6Gl1JhiyMvC/Ti3k
         KiEHqJicHui4HFNs3+FoX2afrvltIR+2kaN7IlVkx5wnlKskFTKJ6aVIH+p0ujd5d0bl
         zUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777407353; x=1778012153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQV+ZUo0kltumkkS/38YnBQvpZ5Ru0K+aNTeRpdyz74=;
        b=BdpI7W5IVUQI/RvZrZSJj2fjqKuAapLoIo4dYz5L/jvGEVteghPSxcmWITMIj9dDsj
         R312AZD3HjOwqcV/0xnhgA2DjOHufAPE+hM9uyB1QrvMcgsCY+Gx6h7qdcKWoL56tT9z
         W5yRLBXzxBh4ZSTy/p0oX3q+fF5TlE1A4eUey73aU1jd6jfrOkIaRzGQ4SiGN9ERbt5+
         ZC2TtiZzt+XAsbUHca+7QBabLKrzpXZlFsoQVb5RQ8Be/TZyVTnZEpOUfPsz1zeYyM9t
         M2rv6Lk6UX9fRwKtTLrJinnv0Pj9JxEjvmruTBCNAITiQcPFVA68jp8eLgRthJ7f9qWS
         wryA==
X-Gm-Message-State: AOJu0YxddZF8RCQqJAMOnRHfq0RkD2MSTWffkmNkE/s5DIPagK6XHtQB
	h2/dwBHYRhFkcMdvNFDXb6N72SwQ7NndhP0qIy0d6edtNdUUWe8J1iJTX2V/HB8KPcpDAYwORGT
	Wist5GCgBfuetYst7yH1eLiOFhSRF8EU=
X-Gm-Gg: AeBDiet7BEr4WIYxkqLGLTHwxXoo12+fegUN3Z7Xj+XSdF2X3oXCoxGkuj2p3sNEGtk
	Om76BBbkYg3dwzDsldXnzQS/5HKal1zr0rkF6pN10wwHfXB2CR091HmAf8YpZ4Zni1nqwzIBpVh
	nc8t2nTDxXsB8NaKIUBnBBNoWGqou5XR5rqPvA1s+GS9qfHbWxvfIxdxohBNrOtk54IKNkT8pTN
	yU2X8oayue0pUFddFwJWzrEa9APi1R1VNP5lp/afI3S+p0rpjMhY6aVK/cZJOrp+VqPecclOBIv
	pttxQTYNcPzrvkPzXYfaTMBhh6jhj/dZgWQQzgo749CyWbDG0Ils8C+05w1KTjeW/zHwSAoybTp
	3c9VesUxU3eXOsnIuE3ZFA5m/tMy50K7ViXlsR0sDKSiYEBX7Hw==
X-Received: by 2002:a05:6a00:f9a:b0:82c:2155:5b6d with SMTP id
 d2e1a72fcca58-834ddabdb7dmr4872052b3a.12.1777407352913; Tue, 28 Apr 2026
 13:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777214801.git.lucien.xin@gmail.com> <20260428140642.GT900403@horms.kernel.org>
In-Reply-To: <20260428140642.GT900403@horms.kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 28 Apr 2026 16:15:40 -0400
X-Gm-Features: AVHnY4Kx985VXS0AEmk_DrhzVNCcnQW-CWSjNlk5dYUnFRn6jZWfAV-j5B80K0Q
Message-ID: <CADvbK_dNRkb8UeGi+x=HhH+tJZSpUTDyHdQLDxUQA1dinbaFNg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] sctp: fix a vtag verification failure caused
 by stale INITs
To: Simon Horman <horms@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Yi Chen <yiche.cy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AAAEB48B951
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-282063-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,netfilter.org,strlen.de,nwl.cc,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]

On Tue, Apr 28, 2026 at 10:06=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Sun, Apr 26, 2026 at 10:46:39AM -0400, Xin Long wrote:
> > Similar to Scenario B in commit 8e56b063c865 ( netfilter: handle the
> > connecting collision properly in nf_conntrack_proto_sctp"):
> >
> > Scenario B: INIT_ACK is delayed until the peer completes its own handsh=
ake
> >
> >   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
> >     192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
> >     192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 392221640=
8]
> >     192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
> >     192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
> >   192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021]=
 *
> >
> > There is another case:
> >
> > Scenario F: INIT is delayed until the peer completes its own handshake
> >
> >   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
> >   (OVS upcall)
> >     192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
> >     192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 392221640=
8]
> >     192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
> >     192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
> >   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
> >   (delayed)
> >   192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021]=
 *
> >
> > In this case, the delayed INIT (e.g. due to OVS upcall) is recorded by
> > conntrack, which prevents vtag verification from dropping the unexpecte=
d
> > INIT-ACK in nf_conntrack_sctp_packet():
> >
> >   vtag =3D ct->proto.sctp.vtag[!dir];
> >   if (!ct->proto.sctp.init[!dir] && vtag && vtag !=3D ih->init_tag)
> >           goto out_unlock;
> >
> > This happens because ct->proto.sctp.init[!dir] is set by the delayed IN=
IT,
> > even though it is stale.
> >
> > Fix this in two parts:
> >
> > - In netfilter: Do not record INITs whose init_tag matches the peer vta=
g,
> >   as they carry no new handshake state in the 1st patch.
> >
> > - In SCTP: Prevent endpoints from responding to such INITs with INIT-AC=
K,
> >   ensuring correctness even when middleboxes lack the netfilter fix in
> >   the 2nd patch.
> >
> > A follow-up selftest for this scenario will be posted in a separate pat=
ch
> > by Yi Chen.
>
> Hi Xin,
>
> FTR: There is an AI generated review of this patchset available on
> sashiko.dev. I have looked over this and I do not believe the feedback
> there should block progress of this patchset.
Right, the feedback is false in practice::

- "No response" is not a clean signal
  (could be loss, firewall, rate limiting, etc.).
- Even guessing this init_tag does not let attackers hijack the association
  (they still lack the correct verification tag and state).

Thanks.

