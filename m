Return-Path: <netdev+bounces-283799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE/eLcSA+GmrwAIAu9opvQ
	(envelope-from <netdev+bounces-283799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:19:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4B84BC4B4
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 13:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF11301A1EE
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 11:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7093A6B68;
	Mon,  4 May 2026 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2eGRh8z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED0937E2EF
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893551; cv=pass; b=tBA+UzAekTlC0V41ehDp4AgHtk5h6Q7N+iXX7XdkVe7HTIeE2Rql3FB6Dsy6fVd2nHatxWj+LozS7ADgGdcBanwxXdGvWrmyiYlx03NI+7vh/Fzkypt4vPNlqXl8WoPQ+1wrhPkRjshZ3IRcCxLaj/bhXwGxCY11fkSLwCMi8SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893551; c=relaxed/simple;
	bh=ZzvoZyDaV+9GQ9a6TuOYJKQ0Evbo9uBsNcTG1aZxwVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKFrgaf+gGdIXzFyuptQ3Hy972Irid3AgUPk4yArcUdi6RMQSrgV1zYMNTmWlZmimQb7irDrnDfmd0HZo/gZ0eFrCcZGat9+E593XfdLtZPfS5dqYNQIOQoWwFUfwlQKjNDNgPYMypfrvOoW75Ot5VXKgJXHm9YkB9peMQvk//U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2eGRh8z; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c305f381eso2560366d50.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 04:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777893549; cv=none;
        d=google.com; s=arc-20240605;
        b=XEornxXFYnIVzo0ISYodTr4JfElZmN19GIAyR5YW78GJDPCcWqMJcWjvdn8x2hcgE/
         6eJDNHZIm9kfwhYhVHqOdW7Q7t4vDm2XDNi0Cu735GoUYwbvo+JEIhvO+jPfK0pxsV2L
         /AKoPVwdP3DqDNEcTOQVqVX4qA1cjMOXEJ/IQNzNbD7izN3YdsYzPtFvNu9yY3csuyZz
         VeF1MY/oqFfsAyFVk73qgVneBn7RCgTGTRTznr0j96LKAgST6bAWe9qvW2f4pIpDYkeQ
         GfAdMGU54fF55607qUlqpAhNOWXj8kuuqw7FbEHhcZtTyOocJdzGOc6nwk5xGFlH4MvS
         pgDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GUktrT8GuU0q956SxbwjSrFItR1lGCQYJxE8ZlZEKXc=;
        fh=9hlgN5zvPeNufJrx7ubzI881Hbl40jgy6tGq0Y7VdCg=;
        b=deNHS4kKZuAXJ/IDwHBlc/mVaPIzUFTbeTEfEXIm/mqNVK4NoAcn9K9T3In2iEePF5
         ntpzaThhVcdbUUQxEUyWUSsa9F+woQMM9dbNwRh+CnyDRwHS8EupAkJRSQBj6XosXd+u
         DsK1BAqm7L8qf2bJ6kW1bPZeLK4DUPHtCWd5c9v3TBVAxp6Werg4tXyMcuCZZdMAnBKw
         Vzwp2sTFAnqd9PKoyWZNqSEZIkuR3HYXCfsrpyd/aYbDi2GkOBwmay3FU7Ha6zUVPZHJ
         5PxLG28EtDXqd/3L/9cvI4H624cdJVm5G6csi/teRFBQXfjmUBnaW4VRzsbMw7kDjDrX
         EMyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777893549; x=1778498349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUktrT8GuU0q956SxbwjSrFItR1lGCQYJxE8ZlZEKXc=;
        b=L2eGRh8zHnK1Ed00MAOaMxx7Setfh4ohIzZspAHSkdMRHG7ougdq94LTquV5beH+e5
         YkSx2oEwDYi45SYxc0VkorpcHIYbp4UCOddj1CiHPP2a573cjoKtVc3aXIig701ZsoFW
         s2KnRxH9yv5aH1JSLLBOmDZHYkfH4CLBN43pcz13uxN/KIdtX7yFULS1ytCqW/eQTc34
         DftcYU0HFUm07+j3DY14XUZ1gmlp5yFhqkIE8UoSvo89AwF/HrRm0oYBI6Y+r3AlTZCB
         3dFeCnSAgWM4pg61FVNramO89OM2tMjhY+VdVxpaNgOOoGH/mpUp9mH2wsNaFwDMi/kq
         e9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777893549; x=1778498349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GUktrT8GuU0q956SxbwjSrFItR1lGCQYJxE8ZlZEKXc=;
        b=j4p8LnTGUeKvISck0D+OaSGlKwtcuBjU7fDgPEFEoKEvikla2DpIzKgK8egk5Dt9XU
         ZYbMdBwCNncYg/JVPWt1i1lDvaXFAZIPIowD/B0WBoRHywLaOtxVLhuH6BvQod89WyCT
         WNIx8QfEXzVrygUCemfF+B0oZZIGm8b1n2VhQavsz8ECOKehav70ezvo3kSmYrWnTf1l
         MzNjhPb4+6CL3f3Euvcu2v2lsS2LAlDeq318RaY7h/H0RGZNI8yWaYKeHZc7ziOcdbhy
         VPcqzyi1wCaBRcX4Wj0gvbFwR5LE2p51S5ZFrl499+cSdy0qt1cFrR/dMvcT+vl8OX3q
         g7Jg==
X-Forwarded-Encrypted: i=1; AFNElJ9s7GIGOezBE9hcE+eVBP9cV5uqt6ZJE0W+tVOtnEut0zt4Wk3qptHiyLAo2f0eWYWmTZFzFxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytbto1uph5nk8EenjaZPY5RDojSpcXCPiFg6JYtP/kpVZL0XYu
	lBXlzfldB3eIYaWeyL/jEbRjSWw044vZgAEVHRkzKcD7fg9gIcP+mFnM39gE2gawAj2W/ONzDEP
	YhkNJa74Zj9awRt2+zYHIjaxCi8WOltc=
X-Gm-Gg: AeBDieuGVa59pdU8n+SfpRDHlJTGxDGdXcvFpq8ZCHCmlRsjDg+LuWig+HZB39YmpKJ
	8BMwPacbvE4gHw8z213b+1gKAa1PxaQLqQu0oA0KwmF/3RVMhm02yq/k0VGeTlQVhIk1QHEziI4
	0uexzPBvCGroXgFgEowtW1afrGEIB9sIdn7qsZRL+qIaDY95QiytYmG0sS9+xzsLRcpsLqjgKtZ
	R3l1Av+nUibgAOTuVVq9c8bE5rChH8skQEyvYgDwzYwODvY0bma29NJjbu6ZRWZzbzOgghCo7k6
	oxOcIL6LVzFungkXq18=
X-Received: by 2002:a05:690e:43d0:b0:652:f423:47e5 with SMTP id
 956f58d0204a3-65c3dafd73fmr7032604d50.42.1777893549046; Mon, 04 May 2026
 04:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324204016.2089193-1-anzaki@gmail.com>
In-Reply-To: <20260324204016.2089193-1-anzaki@gmail.com>
From: Ahmed Zaki <anzaki@gmail.com>
Date: Mon, 4 May 2026 05:18:32 -0600
X-Gm-Features: AVHnY4IY0lLYrd3lltgEmZEsaExiL_o12SlXBsrcMKQ_K6GyfdPRWP-pijiOczM
Message-ID: <CANczwAH0_RZqdi+XheKzwviwvDJeXm98pt7Ki0SkcfWVAWKsaw@mail.gmail.com>
Subject: Re: [PATCH nf-next v2 0/2] Update (DSA) netdev stats with offloaded flows
To: netfilter-devel@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	pablo@netfilter.org, fw@strlen.de, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com
Cc: coreteam@netfilter.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1D4B84BC4B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283799-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,lunn.ch,gmail.com,netfilter.org,strlen.de,kernel.org,redhat.com,google.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anzaki@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Mar 24, 2026 at 2:41=E2=80=AFPM Ahmed Zaki <anzaki@gmail.com> wrote=
:
>
> Some devices (notably DSA) delegate the nft flowtable HW offloaded flows
> to a parent drivers. The delegating drivers cannot collect or report
> the offloaded flows stats since they have no access to the underlying
> hardware. This breaks SNMP-based network monitoring systems that rely on
> netdev stats to report the network traffic.
>
> Fix by moving the offloaded flow stat reporting to the nft flowtable
> subsystem. The first patch adds a new stats field "fstats" to net_device
> that is allocated and updated by the nft subsystem only if the new
> flag "flow_offload_via_parent" is set by the driver. It also report these
> stats back to the user in dev_get_stats().
>
> Patch 2 sets the new flag "flow_offload_via_parent" for the DSA driver.
> ---
> v2: - added the new "net_device->fstats" field since the existing
>       tstats cannot be used since it would double-count on devices that
>       already use tstats for hardware MIBs (P1).
>     - fixed the outdev ifindex logic based. See new func
>       "flow_offload_egress_ifidx()" in P1.
>

Hello,

This series has been marked as "Needs Review" on patchwork for about 6
weeks. Anything I can do to help?

Thanks.

