Return-Path: <netdev+bounces-275613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE/II0/E02mqlgcAu9opvQ
	(envelope-from <netdev+bounces-275613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:33:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D643A420C
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B641B300F9C4
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E66B3806A4;
	Mon,  6 Apr 2026 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aterlo.com header.i=@aterlo.com header.b="LmQD3mqt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572837419B
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485780; cv=pass; b=Ax3j2xkKInKU+jbCdmre2eHQdczaE6IQLzHarhhHZkusAJpYWy82rwR+Md6S3UTstLd4IDTCZ2wnYtKh7os2cniRXckzKu2u7K0s2r0HgO9J82kEBd+1Jzk/ZIr7mCfC0LAzAg4YWeg/3npVmdhLrCOy7R5tZmIDlPGNC4TYscE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485780; c=relaxed/simple;
	bh=B/vhaw3liFExtEgqXBRK3VsQWVBsbRz0r7MWWXvThEA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mvg0AmeGYaI+pG4ueKBr4OaQcB1zMqe7yb28rqMRPQGBiXkJij7THx1wLrojvky/yL96+ZSrSGMZSqKaUG8rlHWPXjJaSL+cCJHjvFb4EY/uZR9Lbj11FQMfWAzrotRLMpHZaiQVixFRPMLFqZ3/+2QaQdZJNNP/4acVflUyJkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aterlo.com; spf=pass smtp.mailfrom=aterlo.com; dkim=pass (1024-bit key) header.d=aterlo.com header.i=@aterlo.com header.b=LmQD3mqt; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aterlo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aterlo.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66f2838ecc4so868398a12.2
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 07:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775485777; cv=none;
        d=google.com; s=arc-20240605;
        b=JlB4TkfLUojT8TsQYcQidC14BD3ypA1mxOYbXNe/U5FJ2gizoi6Ll4knP5YOYoc+Wh
         JsV5gg4XbvrhYEz24lWD2AWKd+MXhXTPcO3RYYE07s1lg4zuEFcSpgwSK/8+RJ9VENo0
         9NqfqhgK/+7/qHY+2OqW2riJI5EexjBnhHV13A7c2IAaeUoQPp96Zhbt7++Ck2CfMXgC
         7PV/9MuuDybmiPej9jJz9C0jf3DChHDGABxlpG6HUu6mdiopJcxz39q0Eqx1+fyk35Y2
         yIk4KbY8pO7GMx6MRnOX8ew8MXk+jNNH/xxNzBySnagfht8Y22WkubC+b64pc+I+xPoz
         OUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=3HZAC7pxTaFLGI8X3MZ8YgDZcADg+zT7L/JFtEDrlcg=;
        fh=CJ5a9cRmGLD14LJqXd6SNi3MU7LHYCcBuDE5mpnvlW4=;
        b=ijtwX5a4/8mVl4oiHBle+tZ8CH7LCT1xWrrPwyv8FZTdemvcHJPplY7PxJtzy3dnke
         SWFpbDpBzzVuIJK+BTgwcEQBpak11r5SlX9JUeHtRTj1ETXZ4FxnoPCx4PWzGvCCFyfs
         rAWt9lmEEn7VO4Z37mofHLsC9ZziRzK1n0U7tTzv81fd9sWZmIDS8LO+1vDwNh/mbcD3
         ClJTMp9J6ydGMJ3TUrh5jhxoKAp4KBkZsslMoZ5O2RcdEYO6N3exH36VFdm4YKH0gSe7
         +fCuVKFZ6pkOBHHXaGpNRtExzuw13nIQ6QMOqs6LfgdEVBhKlIrXwqpaGKHfWKM9ZgiF
         AflA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aterlo.com; s=google; t=1775485777; x=1776090577; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3HZAC7pxTaFLGI8X3MZ8YgDZcADg+zT7L/JFtEDrlcg=;
        b=LmQD3mqtrDDEdT83w2PpHddGLQYFkOJMgjlurprNB5rbP2LOlIictmbPHlgoT5j+K0
         qkDmeZPpqzTerGneEAElQHCjlNNJ/pRf5CTKAE0jxE/sXTPHnat3CpiHnWdHTHoCoZQ0
         qgf0SPlwJef577kMBukGdiPNwkLRkN3nDLIyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775485777; x=1776090577;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HZAC7pxTaFLGI8X3MZ8YgDZcADg+zT7L/JFtEDrlcg=;
        b=G6Okpai0z8x7wqm4l8XYUoOk+FJdEgZjpFy+cCpjpHMJf40qtPH26auq5VQDwq28YZ
         a8tm2ugoXu8nrMa26PMsMDAyUlb2fRm9X4nsYsNZ4VcbUhEFhY/wVfckZLYcE6AhAAYA
         xAJDJKqsLfipdBblGnf8NicXNvsQdF/x3bOg00/wHNEb/lYzWbW/+CN0mEFFztcRE04n
         DLatTrrb0DsOGyPvhc88bE9dKjdpzq1wHtT28fRlcLyU3Y3r3UjTOlo9GWiq0Rc12ljK
         5EdBbG5Rsd0a8HcjfTo3poTQNKm4n51RvldtOZfKJJTJrFTrx1y/zmvX7tNPY+g5asbu
         LmWg==
X-Gm-Message-State: AOJu0YxGoE8sTu3lucuUWBy+kUfBFZp6JE6CFJuJzUUwwd/qIH9f1wZE
	QOe8tRHY8EeFL4DAYOJei+hhgTuwmq09OUzIotr4mm2XihVYHGOOBPgf0deD8cT4BuzBKcUCnTI
	mgfUQfbylo/JnmwTM2/wz/hyQXJY/XebWlO+pL9zhcqnbaurmK5C5Q/I=
X-Gm-Gg: AeBDievQ5a/FFu1xhS1kLRn4QEl5RUG88Hb1ozJKNfKcq3LuBJgs7JskdNzj3SfW8DG
	3xgvvFh5NqcdspFQmSdi4W+pv1o1GxSHhoYFHTOFAXpvH+SlT8SRuPfdIPZeaP9n0YWY+Yk3CkA
	THy9ywj4NMMQx6XillAkQkfGodNKOSWhuDeZa3QBocFX1OElFpqShxlOfihYRo2yeuojVpIw6IS
	UgzYavGiHJxn+2FQdlMU3hSSdDH97nKulNc+qYSuLrZa3Eb+pXOkaPeagYtBtEK4S/dqQnoWP2I
	/H80TfgZ7Q==
X-Received: by 2002:a17:907:a286:b0:b9b:e687:7ca7 with SMTP id
 a640c23a62f3a-b9c67b8bb7amr636108166b.50.1775485776923; Mon, 06 Apr 2026
 07:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Damilola Bello <damilola@aterlo.com>
Date: Mon, 6 Apr 2026 10:29:25 -0400
X-Gm-Features: AQROBzA0l_6uYw21rjicy80N2VO5Ze9IIh2JXxLnne749Y21sHD2YRDppsm-R7w
Message-ID: <CAPgFtOLaedBMU0f_BxV2bXftTJSmJr018Q5uozOo5vVo6b9tjw@mail.gmail.com>
Subject: [BUG] net/sched: skb leak with HTB + fq_codel on packet drops
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[aterlo.com,none];
	R_DKIM_ALLOW(-0.20)[aterlo.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275613-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[aterlo.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damilola@aterlo.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5D643A420C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Description:

Using fq_codel as a child qdisc under HTB results in continuous growth
of skbuff_head_cache objects when packet drops occur. Memory is not
freed even after traffic stops, and the system can eventually run out
of memory.

Regression:

- Works on: 6.18.16

- Fails on: 6.19.x (tested on 6.19.10-200.fc43)

Environment:

- Kernel: 6.19.10-200.fc43

- Distro: Fedora 43

- NICs: ens2f0np0, ens2f1np1

- GRO/GSO/TSO: disabled

Reproduction:

#!/bin/sh
DEVS="ens2f0np0 ens2f1np1"
for DEV in $DEVS; do
tc qdisc del dev $DEV root 2>/dev/null
tc qdisc add dev $DEV root handle 1: htb default 10
tc class add dev $DEV parent 1: classid 1:10 htb rate 100mbit
tc qdisc add dev $DEV parent 1:10 handle 10: fq_codel
tc filter add dev $DEV parent 1: matchall flowid 1:10
done

Generate traffic exceeding 100mbit (e.g., iperf3) to force drops.

Observed behavior:

- fq_codel reports packet drops

- skbuff_head_cache grows continuously:

- grep skbuff_head_cache /proc/slabinfo
  skbuff_head_cache 12144512 ... (continues increasing)

- skbuff_head_cache doesn't clear off even after traffic stops.

Key observations:

- Leak only occurs when fq_codel drops packets

- No drops -> no leak

- HTB + pfifo -> no leak

- fq_codel as root qdisc -> no leak

- cake as root qdisc -> no leak

- The leak only occurs when fq_codel (or cake) is used as a child
qdisc under HTB

Expected behavior:

- SKBs should be freed after drops

- skbuff_head_cache should stabilize after traffic stops

Additional notes:

- This appears related to skb lifetime/accounting during drop handling
in the HTB + child qdisc path

- Possibly related to GRO/GSO interaction or skb segmentation handling

Request:

- Is this a known regression?

- Any guidance on further debugging or identifying the offending commit?

