Return-Path: <netdev+bounces-283013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SChKDhno82mE8gEAu9opvQ
	(envelope-from <netdev+bounces-283013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:39:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC864A8E42
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 01:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A86CB30137AB
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAB83D3494;
	Thu, 30 Apr 2026 23:39:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E133C553A
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777592341; cv=none; b=RgT/sPwIWetfxYUd6pu3tnDgnJ5KxExA1NXmrQ8HTpzCWHA5VAf2Emu6Cw5yEYbTMOAL2i7uVdAno7w6lAm1/oR8PVN0nCCeeYnEJOXeP9NHqRBLo4Zmw1Ndj/Qr6BCw/1SXTpuAmfM/NC5+M9PyxXhsyuBYK+yz+evCibto94U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777592341; c=relaxed/simple;
	bh=ebHuBoW02qHmf08ncQRJXUoPQIQLHDcgiezetLfnhO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pC+QIUxCguH3x5I7VCECEaHis0yqzw3KFXPwASQCx22gGEGdB5nlqfqCvvZkRbvXSDxTQHeyvTdGs8JHMWEZ8VCDTBvz54Ymk6Uuvf/ZO4Vi8sqdEsioJxvpP4Y0f//hJhYFmLQuryunJRnyT7FUdla7s1NVDvvQ+ouoIL/+9xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-50d7c12e48eso12296331cf.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777592338; x=1778197138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI5s/gjPC8JmnFz7SoHnBZF2JdcqfzQbMV/kK5cvcdo=;
        b=o2Ie75VEPNKfpPDZxsA9PcJ1W5PH9F6y748BgMWgn2c4tnsSsQjGizx0sc1bkUmIRC
         cJiLnw4IGQrFSHj8s6N8cY7i7UH/DcutKZ4qgW9waUTctXrdMZra2phwsTaROscx97lB
         cx+gvfZ78T8UUA++LGycHkOvFW412lHQlsKuVMCAhoz0MjhLD1tVwqm0Nq14Y3+fYn4J
         kWfcwzxf91lPA0clV2TkSCS3ewt3BvRrDeJ3bFtjGWFab9iC/x/jfj+3lj403gxVouEX
         qwFlVeJJDgg2K5KVYHdKsIhU2E4V7op2lxzT22VgXfsmhasammtraaFPC7xhb91SvdGx
         iSjg==
X-Gm-Message-State: AOJu0YyRF0RiM+3Rj9Kp8DDVkTLa2930Kz8iqUQW7c0CVqz+WuiiN2PZ
	AvDKGl1zEZ2w7FdGtQit0NsngbTarZxnsEFkHKO2KJEgGrgURaQBusI4Y+Uyi2zEaLs=
X-Gm-Gg: AeBDieuva7bMz/UWxs+i4WEeW44bgxERMhY78gttYZpXXhlLTw93zFP18CkV97hvDHX
	rtvh2HZnj3pjbp3yzD4Sqiv20q+AiKiTmNRjBN+3VliBkVkcT3rnuTRAJ+cRoJsJYP+ENRQNnmh
	IAALcUEQ97VVb9ZMyEcy/WogNiQtmnWbXgmb1LpeDqzGcIk5iYEssjFnrcbEUzDotmrLAmNn66g
	DJAFfZnE7SYeZOygMhperfb9lo1fR5UOZRaaZ607LQuE8niIjwBH9F2lWkrk0uZSMb+GJmHNnLd
	UR8/Anc1k4i0kYZaJsR/q8OSSfSKzHnPooLZ8bUZmrbN4g3MppvgN5rOKBvj65dkDg8kBE1e2Vm
	jQJcoOtmgGnm645KlW7DgKL+en07BfQO1SAimi6HbP+nB4AhIdhEcMu66MgZf0X+2UtL2SObx2y
	uxYolbmUo1poX/7ZyBx/UwKZDPD4oQkJssiFB1EuTvhTLHGMU0hThGwtBvgHr2YIA8bgibc7lCh
	T9NtZNW
X-Received: by 2002:a05:622a:248d:b0:50f:bd19:657b with SMTP id d75a77b69052e-5102d13e8ddmr62263561cf.10.1777592338555;
        Thu, 30 Apr 2026 16:38:58 -0700 (PDT)
Received: from im-t490s.redhat.com (89-24-32-159.nat.epc.tmcz.cz. [89.24.32.159])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51040934199sm221cf.13.2026.04.30.16.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 16:38:58 -0700 (PDT)
From: Ilya Maximets <i.maximets@ovn.org>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Yuan Tan <tanyuan98@outlook.com>,
	Yang Yang <n05ec@lzu.edu.cn>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net v2 0/2] openvswitch: fix self-deadlock on release of tunnel vports
Date: Fri,  1 May 2026 01:38:36 +0200
Message-ID: <20260430233848.440994-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8BC864A8E42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283013-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org,vger.kernel.org,ovn.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dpctl.py:url]

Two patches - the fix for the actual bug and the selftest that reproduces it.

I missed the self-deadlock in the original patch that introduced the issue,
because testing required code modification in the ovs-vswitchd to force it to
use legacy tunnel ports.  I thought I made the change correctly, but apparently
something went wrong and the tests were run with the standard LWT infra instead.
The selftest added in this patch set will at least prevent this kind of mistakes
in the future.

I mentioned, however, that these tunnel vports are legacy and not actually used
by ovs-vswitchd.  RTM_NEWLINK + COLLECT_METADATA is used in conjunction with the
standard OVS_VPORT_TYPE_NETDEV instead since 2017.  The code to use the legacy
tunnels still exists in ovs-vswitchd however, but only as a fallback for older
kernels and we're planning to remove it in the next release.  I'll be sending an
RFC to remove support for these legacy tunnel types from the kernel, as they
serve no real purpose today and only increase the uAPI surface for CVEs, but
we need to fix the known bugs for stable versions.


Version 2:
  - Added Ack from Eelco to the first patch (not to the second as it
    changed a little).
  - Removed now unused import socket in the dpctl.py [pylint/ruff].

  - Regarding comments from both Sashiko instances on the selftest patch:

    * The background process is not waited for / not killed.
      If it hangs it will not be killable anyway, so it's not a problem.

    * The 'gre' choice for dpctl.py --ptype is not fully handled for --lwt.
      While this is not needed for this patch, I agree that it's not
      fully consistent.  Added the proper handling in the TUNNEL_DEFAULTS
      loop in this version.

    * Python version concern for argparse.BooleanOptionalAction.
      Python 3.9 is the oldest supported version and it has it, so it's
      not an issue.  Creating extra detection will only complicate the
      script with no real benefits.

Version 1:
  https://lore.kernel.org/netdev/20260429151756.4157670-1-i.maximets@ovn.org/

Ilya Maximets (2):
  openvswitch: vport: fix self-deadlock on release of tunnel ports
  selftests: openvswitch: add tests for tunnel vport refcounting

 net/openvswitch/vport-netdev.c                |  6 ++-
 .../selftests/net/openvswitch/openvswitch.sh  | 37 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 19 +++++++---
 3 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.53.0


