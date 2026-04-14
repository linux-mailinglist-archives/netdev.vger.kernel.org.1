Return-Path: <netdev+bounces-278534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UObLNKBn3mmxDgAAu9opvQ
	(envelope-from <netdev+bounces-278534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:13:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E69C3FC697
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 18:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D7513072E3B
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA56C3ED126;
	Tue, 14 Apr 2026 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJpoLY0J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IY2rJ+zm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A313ED105
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183032; cv=none; b=pI0L3vpomQBab5sVjb/Vk6/ilnPYdHUyZLuPiJRefO1dSVU6cWJBHa4iA3Yi2b7gbijr57RhF+i8Kq36yXtbJPY8LJGNxFRGBlAsVlY4VLgrlduq5WVGmYCvnoTKfFD1TNmUcZ86xk9eMk4haNJ+IqsBGQfLRvrVu1I8wLkhD34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183032; c=relaxed/simple;
	bh=2xDcIT3f78H7eKHRPribLJ8e2LZJl4ii3oNMP2ytE+A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rLs1Yhh3ZAzaroL4ApTQpP+zdZ/58Prce6bnsXqtOqlNpQqE6e5MdhSnFe7IyXJ9rtm+BxfJK/ke4bwGWHFY6KEBWujW8KGQvIhtNQByLDg+mYxTCbxpavl5OG3oPeunvyF8QMlYPBL4mhbK1Z1ek0hnRlIVAxbUlzgljpFj/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJpoLY0J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IY2rJ+zm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dXlPrnMYysHI4EKQcfAK7A0hsCX8t6PffR9osO+JIF0=;
	b=DJpoLY0JbhpioZh8KcsM9sESHiJFD9Wn1U8+UKD5eDMLXWi0oIAFA8UCuPu+0LwEPPxjjf
	aD1gVOKX7B84Z4H5McqDlxF7n7JUpdZRJdpIodZynpegGAJJPMRJi1bPG2MaEuFt/MZ7na
	NTSlFgov9QoW3TqWJmCZnFGO8ulM/Og=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-j-owx9PuPpCOE9k9iagQrg-1; Tue, 14 Apr 2026 12:10:26 -0400
X-MC-Unique: j-owx9PuPpCOE9k9iagQrg-1
X-Mimecast-MFC-AGG-ID: j-owx9PuPpCOE9k9iagQrg_1776183025
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d7d03e1e7so1160575f8f.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776183025; x=1776787825; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXlPrnMYysHI4EKQcfAK7A0hsCX8t6PffR9osO+JIF0=;
        b=IY2rJ+zmhY8nvEQzW6RRWXpktAcoH9E/S4apYcd3qEHsCvcl0tTuKq++jMiEL9ywJs
         RQ31BXOgtor9IRbKng9AFqgU377NOJbSxi74c4hWdPb4f5dO2f6NMBEBC2mtS7OjVBkS
         7hM70qn4NE6yr3UZG5WeluE8yaSx+iSlzgDh1UUOh9U5lQuexeQZMQRfL3xyXFZKx4S5
         n2KBLfNkN/kXAeKCVHN7lcmxLLbDJYfhkd+1OK2NwIoNwiN6p/DPA9n8CHjfT0lUrakK
         tfvgtm2HcaF+qoe3YiarIlJl/t9O2f/ZIm8Vj5NYfNlf8nNLSZpdNOKva7J8sxH8b7HT
         zMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183025; x=1776787825;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXlPrnMYysHI4EKQcfAK7A0hsCX8t6PffR9osO+JIF0=;
        b=kMWGnSl1Z4jNn5Sipd1m59l8AxiXCsuMFEpw/Q+1zwXDP93ijjSjQL3nSNnnm6jtla
         3mKThRVsKQJnpkzBZF+nfFoQXVLkgJ6a57nLiDbI5orkNC1Wdbe596763Pyp9ME6Gs7h
         W4qtt6cqo4HudVDm9pDXYlK95Z8lPExbJt4MS+iL6lhT2/w/GSUjBQ4+yS3Jysxy7NL3
         yxzjqlDPvvhoqHs+wGuHknzVP7DYN6Nq6I8qaZugcHeOi2snAnXgCOG3UkAnmZF0KIcR
         clv4FeeOyKVPIjIZsL4ODJy0zf+EqHeYVQM4kH6CUAUXM5ecM5H1cwfWvk91Qq2nisyO
         tgYw==
X-Forwarded-Encrypted: i=1; AFNElJ/5WRdjbVg2/t0Db/JGKEn4C0ZTKA0v4tnH7rm2421+l2hU2jIJK0Kwsj2FO/8/cThVPvCHKMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynF8/OweiysGxakMGvztykCGpqVNqCgo8xnX2DMnmq2JVkpf61
	qH91HGRjzGW4zqZwMSr5Ft7dso5ED84EZs+df7RK9x/iHJFH6EkBLi69eV3ateGXiBYvElBJDEB
	jY4PCdpaYCjSlt2y8Opl0twr2kPLKskN39t6pUM4CGojpmelILTPydraT9w==
X-Gm-Gg: AeBDieuIovSoJSWo+Ugr/YHC5W5QpflZm19EMc7Ti+lAKuIxBOvAaGuqDyqnaaBh7vG
	QoRiumICZZc+X6HjepERBJ6EP4B3fA2CBwnlSQQ9XcV1HAPtpkETl++X0g0//dbDp4eV/CgRo/j
	eIb+cOBmX0le4ZNhKCs5yRv7K6/o2LA2ipgGo3vnuUTcTTINo4EgcU0iBLhDIc11BrhABOEozoe
	AIb5kHz+LruOjXEKTV30NmeFJL5RqddHJkSN6vh+B455wb3V0WQSHMHkGqpve+o9X12kXzTmQf5
	TdHLx1RS4mEOGu+snyKMYyy7ngaC7yOv/byCwq+ev9OFW2FnSrhN4eqoPzGSYcAF6WzX225nvsf
	GwzUodLLNxmhlHGTg5sYnwMUNU3yjsuhZvXe/T6sIdwPwZw7aV09Sd4z3XmMy
X-Received: by 2002:a05:6000:24c2:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-43d642a7a6dmr26523566f8f.23.1776183024758;
        Tue, 14 Apr 2026 09:10:24 -0700 (PDT)
X-Received: by 2002:a05:6000:24c2:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-43d642a7a6dmr26523479f8f.23.1776183024220;
        Tue, 14 Apr 2026 09:10:24 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:23 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH net v3 0/3] vsock/virtio: fix MSG_PEEK calculation on bytes
 to copy
Date: Tue, 14 Apr 2026 18:10:20 +0200
Message-Id: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WM3wrCIBSHX2Wc6ww9rmld9R4RselZk2gOHVKMv
 XsiQevy9+f7FogUHEU4VQsESi46P+YgdxWYoR3vxJzNGZBjw2suWO9et4nowRotVadl3RxJQr5
 PgfJWVBcYaYZrLgcXZx/eRZ9Emb4m/JmSYJy1FlXdG+qV6s6B7NDOe+OfxZJwS6oNiZlEwoMW1
 uhOmT9yXdcPjfM9XuAAAAA=
X-Change-ID: 20260401-fix_peek-6837b83469e3
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-278534-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E69C3FC697
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

`virtio_transport_stream_do_peek`, when calculating the number of bytes to
copy, didn't consider the `offset`, caused by partial reads that happened
before.
This might cause out-of-bounds read that lead to an EFAULT.
More details in the commits.

Commit 1 introduces the fix
Commit 2 introduces some preliminary work for adding a test and fixes a
problem in existing tests.
Commit 3 introduces a test that checks for this bug to avoid future
regressions.

For disclosure: this bug was found initially by claude opus 4.6, I then analzyed
it and worked on the fix and the test.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v3:
- Addressed reviwers omment
    - Dropped test client, reusing the one already existing
    - Minor changes: added comment, improved commit messages
    - Rebased to latest net-next
- Link to v2: https://lore.kernel.org/r/20260407-fix_peek-v2-0-2e2581dc8b7c@redhat.com

Changes in v2:
- Addressed reviewers comment
    - Test now uses the recv_buf utils.
    - Removed unnecessary barrier
    - Checkpatch warnings.
- Added new commit that allows to use recv_buf with MSG_PEEK
- Picked up RoBs
- Link to v1: https://lore.kernel.org/r/20260402-fix_peek-v1-0-ad274fcef77b@redhat.com

---
Luigi Leonardi (3):
      vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating bytes to copy
      vsock/test: fix MSG_PEEK handling in recv_buf()
      vsock/test: add MSG_PEEK after partial recv test

 net/vmw_vsock/virtio_transport_common.c |  5 ++--
 tools/testing/vsock/util.c              | 15 ++++++++++
 tools/testing/vsock/vsock_test.c        | 50 +++++++++++++++++++++++++--------
 3 files changed, 55 insertions(+), 15 deletions(-)
---
base-commit: bc28831d7a09f7058cdca4658d81e5faf635bed7
change-id: 20260401-fix_peek-6837b83469e3

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


