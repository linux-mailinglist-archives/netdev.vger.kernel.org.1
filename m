Return-Path: <netdev+bounces-280982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOIXJPVO62nkKwAAu9opvQ
	(envelope-from <netdev+bounces-280982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:07:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA645D752
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 13:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B9A13003832
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6C639B952;
	Fri, 24 Apr 2026 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKXXWHT4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F8B39B97B
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777028851; cv=none; b=iQ3f+HME4520zn4k2ISDs+ixG4ehF0yY/eQNTue2cfU5MQm86U0TQCPeO70TWdKo3kU8qWlFXCd/t2e0HJ4O4g6NeZrxGUjEu9btzJy/qp3FlNvjFeTTrq+MDoD48tchuHA7gNuOkj+c2nW165w8LekAKOs/wDfc994BpgVxFYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777028851; c=relaxed/simple;
	bh=v4hW7UgDIpbZQUBaJFqkHQNKbKj8ZVAGkmTyqK3cCsU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=FFKX1VYuxVMmSeKbtvMg3s6QUU/1/x5kdUXkUUAgtesl8BDJJRBeN2vK5W3yMrQRrGPmYTtcyl/L/x3zgf7dqblzrslC6g7E88hS81dQP55Wt3okpNtVgB5U1M6k6y5rjzy/GuBf6OZVBpnKqSY9+JQUkrMUDA1g2JhR6scVYPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKXXWHT4; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8acb856a674so92715846d6.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 04:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777028849; x=1777633649; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v4hW7UgDIpbZQUBaJFqkHQNKbKj8ZVAGkmTyqK3cCsU=;
        b=MKXXWHT4Ce/YTbRScuw5EDuwYTt0YPwu7VK4vHzZR4+y3TA3E0fx5foL+3k4a1TXb3
         DwD6TbL8guVIZZZqC+Be1G0gUvjUKeJvYH/epHWw2clURmo8/JM/O7Fefd41udtjIBGX
         kHevTM9VL9qbcqBnunmILZckt1lb8DGI5YM6Rz9rJLtAgj7gjZ86M5ELFqH3ovtQuaow
         1eu22lfCuY5HJI9F0FN3rK6z/7Mc0AEM0WgWw8GvW6OdvH6IHu+BU1NoWwjQdO+z7ApK
         aFcv4KpJZqI6dzUO7WDeKg5h3DCTXQW5tvq4k8DfReWweo8dJ+FBOm+6lDZy/MG77h/3
         nxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777028849; x=1777633649;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v4hW7UgDIpbZQUBaJFqkHQNKbKj8ZVAGkmTyqK3cCsU=;
        b=AZ2LPtblSSIjmuEclpZHyJpdS90Sb/z32G5ZhBprSJbBhYstV47CoFdroJaeh82QGD
         wMIfq9aiGQRtRmPfbOK+ZrKF4UnsLODz/mQHAic6RyuOdtSql5HYydp2Yu50yiV/IJ7f
         848+rGmpA6bZLwf5fLwz25gMDjKiGvdiVtjnznJVZl/R6LebE3hNLIRPr4i7pAFqQrfF
         Rpy4ekVOAuroQL6hjZv+CpWi2/XyVG/f4wowyvaOXKc4wiCEZZKG3kJYHyPNzbZ0mSkS
         mVUhQ1s361Z5ZqQ3bvzfRYeKrPuYOI5RK60bFpst5+DyqWu2EiqfSBUDe8y61dJzSGCE
         ZJZQ==
X-Gm-Message-State: AOJu0Yy/68xUWQ62xeTuBkR/v6ykqCv0AB12ehexnat6gu18ka4plb3B
	X/nYdCHpaGxmwkQ6G+Ta/YeFPiV1jM/pCf/LffcChMYnNpK21VCZimn4O6AyfOAw
X-Gm-Gg: AeBDieu85a6UEgjqn9pcAb/TRuOPJ/wyjm4AD1A+L/EYNfd0nstBZKdL/suCHZdifH1
	d+GntqMbn8gJgldWfQu4me9/KNBxEoML6oEMTQKGecqKuQC5zKcknBO4ljY4dgj2ij2UnMhY5ur
	1f4BijwFLRs/lrsUj/T8/1VECg0X+2EeM/o3QOGyoLbgHI9oBP69gI1mVy2iJZPxQ0jZp3+cnMQ
	zFUKopcGK+wSMZMznhiKWkFz5Ls3RlNGG3o8ODWkHPvUnPbzewrlGW/Wpd8AwMw3dtEtP2mXC3J
	jkCgOYP+pw7/2Gd+gC+GK3B6KzPyJugQGb+ZrugYVCGuK9cu8aw/ri2Iyx3AdAIyCt0lR/o5Lph
	tWAOCbrkMR4PfpUUqeNxk0H4x98TgMKl3QEQiPDsWFfIHlfEgi9BW0Ebzdf1caX4WA/9FZHTb0J
	VO7dMveCUlYzuTvyZKcBNpEmKr+zYS7tUOMKFOtkqI7SXgrtGNEHFEolrdtS8LuQWpnS9ezjESv
	6r5dDce55prZs2U4zkX
X-Received: by 2002:a0c:e003:0:b0:8ac:a6f7:8a6a with SMTP id 6a1803df08f44-8b0286fb9bcmr343493596d6.16.1777028848734;
        Fri, 24 Apr 2026 04:07:28 -0700 (PDT)
Received: from [192.168.2.35] (1750310-static.rochmnaa.metronetinc.net. [152.117.88.197])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae7d79esm178388646d6.36.2026.04.24.04.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 04:07:28 -0700 (PDT)
Message-ID: <96b4d723ac443f3a42680fa1c8b94b929df39da3.camel@gmail.com>
Subject: [BUG] mlx5: VLAN-aware bridge drops all traffic in legacy eswitch
 mode without promiscuous
From: bryan <bpliscott@gmail.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com
Date: Fri, 24 Apr 2026 06:07:27 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 32DA645D752
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280982-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bpliscott@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:url,apalrd.net:url]

Good day,

I wanted to check whether there is an open bug report or known fix in
progress for an issue that has been affecting mlx5 users (specifically
ConnectX-4 Lx, but likely broader from what I have seen other
reporting) since at least 2021:

When an mlx5 interface is added as a port to a VLAN-aware Linux bridge
(bridge-vlan-aware yes / vlan_filtering 1) in legacy eswitch mode, all
traffic stops passing through the bridge. Both tagged and untagged
traffic is affected. The same configuration works correctly with non-
mlx5 NICs (tested Intel, Chelsio cards).

The only known workarounds are:
1. Enable promiscuous mode on the interface (ip link set dev <iface>
promisc on), which bypasses hardware VLAN filtering but has security
and performance implications. (this is what I am doing on my systems at
the moment)
2. Switch the eswitch to switchdev mode, which was fixed for a kernel
panic in February 2023 (net/mlx5e: Fix crash unsetting rx-vlan-filter
in switchdev mode) but introduces other issues including MDB errors and
is not suitable for all configurations.=20

Based on reports I have seen from other in forums, this appears to have
been introduced somewhere around kernel 6.1-6.5, possibly related to a
commit that changed promiscuous mode efficiency in mlx5_core. I was not
using this hardware at the time, and cannot confirm firsthand. The
NVIDIA out-of-tree MLNX_EN driver does not exhibit this behavior in
legacy eswitch mode, which strongly suggests this is a regression in
the upstream mlx5 driver rather than a firmware or hardware issue. I do
not have first-hand experience with the mlx5 driver ever working
correctly - the idea that it did historically work correctly is based
purely on the reports of others (and the existence of old setup guides
that do not mention needing to try either of these workarounds.)

If it helps at all, I have tried various firmware versions on ConnectX-
4 Lx cards ranging from from an old release from 2017 all the way up to
the latest 14_32_1912. There has been no difference in behaviour with
regard to this issue.=20

This is well documented in community forums but does not appear to have
been formally reported to netdev that I have been able to find. My
apologies in advance if this has been reported and I wasn't able to
locate it. Here are a couple of forum examples where this is discussed
among other affected users:

- NVIDIA Developer Forum (opened 2021, unresolved):
=C2=A0
https://forums.developer.nvidia.com/t/vlan-aware-linux-bridging-is-not-func=
tional-on-connectx4lx-card-unless-manually-put-in-promiscuous-mode/206083

- Proxmox Forum thread (2023, ongoing):
=C2=A0
https://forum.proxmox.com/threads/mellanox-connectx-4-lx-and-brigde-vlan-aw=
are-on-proxmox-8-0-1.130902/

- Community writeup with analysis:
=C2=A0 https://www.apalrd.net/posts/2023/tip_mellanox/

Has anyone bisected this or is there a fix already in progress that I
did not find? This affects a fairly common hypervisor configuration
(VLAN-aware bridge for VM networking) and the workarounds are not
conducive to production use.



Thank you for your time,

Bryan Pliscott

