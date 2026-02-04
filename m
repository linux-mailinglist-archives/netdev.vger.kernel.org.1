Return-Path: <netdev+bounces-256600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yErEMuP0gmn6fgMAu9opvQ
	(envelope-from <netdev+bounces-256600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:27:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 473BBE2B14
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B85F8304C0B3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0D638E126;
	Wed,  4 Feb 2026 07:27:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8638E11F
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770190020; cv=none; b=o2/mS5cRRO7Qk2uaSDJgZ6Ud7DEIy9ebD9AGQoKDLQRtL15Ynk1wTWmxwD7in1rtFxLjB3QJHl0RIxa1buzwxqH3md9P3KCON23yvo8XEQcZdC1adcZ7jy9gs6VsEY4SxpYLjmlIFar4x6SYWEBTs6qDn2QUix0/8Aym3rDZG74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770190020; c=relaxed/simple;
	bh=Tur/jNp7nb9DTpSWnGbTdI6/eta0cvQ+zVNHkCq0Zfg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L3gYmip84wgIvr1D3z5D2z2DP7g6LzewkFTSWri3yd74NvGwBiDfEGPjJQK8sH7gqaueoN4C3r3vc1T5BYHTm5ZM3qCJm4dAikdU7CMLNGKNh/wvOSpRCmjUH7clvIT7h3slKXRS1RPTiYrv/RXfSjAIsSnQt4TSETEB4SMSWNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-794d80febdaso33383027b3.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 23:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770190019; x=1770794819;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjKpqs0wcZlj1n2EndztA/RlUaeDRvGIw0Pnn55HbcM=;
        b=XgHQmWON3bgDvtcab9H4AWchP5TnbqM7jxCCQMo6HsBYqbOFxHhQ3S6iI6gZzsm1Om
         5zHMZi8RBSlN+rNdvQb9oeMUCqK/zH+NfZbVpvosUA2TQb7UbLhoXkNUjcSLYuvv+DEr
         A+yaaIJGm7Y8IDpMmOPXqlj9yeTtrJxgiLYZLBexIJ44ZTbJZYosfvDl4yekQl+Q9pHk
         gLY+hWr2+G8TVq+ZeU7jdEh63tZfmPX9QYLGrzAJLKyqk2i7mKz84a9wlNYE2h2VknDa
         wDyYgHiGN9Tw6wYvTVtEH+gYlPh0kdQpH6Yx+ZDdRjv0Y73lAY0/UEWx5Q0DNnRAiqkL
         7kpQ==
X-Gm-Message-State: AOJu0YwFMajiRWri7vMERwzra8Fz+fHJRFQqifj4W1WZrl8d8upC1AXY
	QOkKAbIkiwIiFF9kNrbVgHbxJ7/yUP8B9bz4cpTxBNHgVoA6W8EiG6Wu5b2BoMGn
X-Gm-Gg: AZuq6aL0BktLeVjhUMCZ/TROQPFUV5ZgItb8qZxJXzITrmGfyGz7H6NccQ6l6ZySwih
	kjFn8KGf5gT2lDxClfYSDCorFaGynE9OhvnSM3L8ueICHpvlzWyUdsu7Dpg99Ba5gIwUnorkFyd
	XuJ+/oBbJtuTwzdiM/u6Ku6wHbkcLxdhyPSoBMg1JJIlv7mbg5VcTNjvu4tt5dLlV9SL8Q5V7uj
	f91pVzJXdPAC7S50F/N27wgtDTMQc0dFTgpnzd6TSIQiTejNwGU3+XcLT8fRgP7Z3ToLTtzpRDd
	WKgipPoJiKSmx/WoDEpas9djBURyQpjzBhHhp7mF8SxO1r3NMgBw+byWWJH/VpnQ3yBZB0kTbDH
	jXJzkcPRar3GutTDeebCVy7zQR3uxLyoyb/7gqCpg2npTRJAo/QUUMujqioPxYE7uOugCp0o+jZ
	H5kCayt3Xwc6tsjdSafLYz62l+dgiNe2N9XnxBaPBQ/GBX61AJmiASppwqrKle3a4g/R/H/ruKC
	Zzi+YY=
X-Received: by 2002:a05:690c:89:b0:794:e13b:f781 with SMTP id 00721157ae682-794fe6796e8mr22216907b3.19.1770190018876;
        Tue, 03 Feb 2026 23:26:58 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794fefa33ffsm14998017b3.30.2026.02.03.23.26.58
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 23:26:58 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79456d5ebf9so65282977b3.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 23:26:58 -0800 (PST)
X-Received: by 2002:a05:690c:7403:b0:792:6c16:110c with SMTP id
 00721157ae682-794fe7e2f6amr18620887b3.61.1770190018332; Tue, 03 Feb 2026
 23:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chen Linxuan <me@black-desk.cn>
Date: Wed, 4 Feb 2026 15:26:47 +0800
X-Gmail-Original-Message-ID: <CAC1kPDMV_8H8k=fP_Ty5-e-rCompUdFX2dzqszj+CyvVK_VWMg@mail.gmail.com>
X-Gm-Features: AZwV_QifZ1AsjLuU52FQhWAahys40MCnpBLhklGt7drNEvI6b9QFngromZLy1GY
Message-ID: <CAC1kPDMV_8H8k=fP_Ty5-e-rCompUdFX2dzqszj+CyvVK_VWMg@mail.gmail.com>
Subject: Do not create /var/run/netns mount point when /var/run is already MS_SHARED
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[black-desk.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256600-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@black-desk.cn,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 473BBE2B14
X-Rspamd-Action: no action

I have observed a weird redundancy
in the mount table when using `ip netns add` on Ubuntu 24.04.3 LTS.
Specifically, `/proc/self/mountinfo`
show two identical entries for the same network namespace under `/run/netns/`:

ip netns add xxx
cat /proc/self/mountinfo

29 31 0:26 / /run rw,nosuid,nodev,noexec,relatime shared:5 - tmpfs
tmpfs rw,size=744632k,mode=755,inode64
33 29 0:31 / /run/lock rw,nosuid,nodev,noexec,relatime shared:6 -
tmpfs tmpfs rw,size=5120k,inode64
79 29 0:40 / /run/qemu rw,nosuid,nodev,relatime shared:116 - tmpfs
tmpfs rw,mode=755,inode64
92 29 0:26 /snapd/ns /run/snapd/ns rw,nosuid,nodev,noexec,relatime -
tmpfs tmpfs rw,size=744632k,mode=755,inode64
1808 92 0:4 mnt:[4026532752] /run/snapd/ns/cups.mnt rw - nsfs nsfs rw
1991 92 0:4 mnt:[4026532753] /run/snapd/ns/canonical-livepatch.mnt rw
- nsfs nsfs rw
2608 92 0:4 mnt:[4026532940]
/run/snapd/ns/snapd-desktop-integration.mnt rw - nsfs nsfs rw
2677 29 0:87 / /run/user/1000 rw,nosuid,nodev,relatime shared:1632 -
tmpfs tmpfs rw,size=744628k,nr_inodes=186157,mode=700,uid=1000,gid=1000,inode64
3091 2677 0:90 / /run/user/1000/doc rw,nosuid,nodev,relatime
shared:1727 - fuse.portal portal rw,user_id=1000,group_id=1000
3087 2677 0:88 / /run/user/1000/gvfs rw,nosuid,nodev,relatime
shared:1751 - fuse.gvfsd-fuse gvfsd-fuse rw,user_id=1000,group_id=1000
104 29 0:26 /netns /run/netns rw,nosuid,nodev,noexec,relatime shared:5
- tmpfs tmpfs rw,size=744632k,mode=755,inode64
746 104 0:4 net:[4026532740] /run/netns/xxx rw shared:984 - nsfs nsfs rw
854 29 0:4 net:[4026532740] /run/netns/xxx rw shared:984 - nsfs nsfs rw

I did some research myself and I found:

1. In iproute2 commit 58a3e8270fe7 ("ip netns:  Make /var/run/netns a
shared mount"),
   the tool began performing a self-bind mount on `/var/run/netns` and setting
   it to MS_SHARED. This might be necessary in 2013 to ensure netns
   propagation when the parent directory (usually `/run`) was private.

2. In systemd commit b3ac5f8cb987 ("mount-setup: make /run shared by default"),
   systemd changed the default propagation of `/run` to shared for a
similar reason after v188.

I have tested a modified version of iproute2 6.1.0 where I removed the explicit
self-bind mount and MS_SHARED configuration logic from `ip/ipnetns.c`.

I confirmed that:
- Network namespaces are still correctly propagated across mount
  namespaces due to the parent `/run` already being shared.
- The redundant "mirrored" mount entries in `mountinfo` disappear.

Should we consider optimizing `ip netns` to check the propagation state of
`/run/netns` or its parent before forcing a new bind-mount? If the environment
is already MS_SHARED, we could skip these steps to keep the mount table clean.

