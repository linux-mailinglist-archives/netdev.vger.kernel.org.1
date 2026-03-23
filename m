Return-Path: <netdev+bounces-270575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKpaHLZXwWmBSQQAu9opvQ
	(envelope-from <netdev+bounces-270575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:09:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 034532F5E1B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A767A3062221
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EF624634F;
	Mon, 23 Mar 2026 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KKvBgedI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4379027AC4C;
	Mon, 23 Mar 2026 15:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278147; cv=none; b=fzlZIqokr4ZDL9K5lUknDtt9smArZMAT/T+r27OpCs3Ox3h7c9F6Wk8cE9px98L75f6Kaw/dANzQAzQh37jkeuLmOfjROfhyjKLSEK6ERmnAu+gkRft4eMEir/UUWKIE3aYg+Jv6N50NWitIW20C0zNmelhzrANLZM+d71Gv1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278147; c=relaxed/simple;
	bh=V+8n2djQSrAn0/iD48NW+grY2jzX6Ew6bZZOy3qArZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTSk1QIgRcR63qktt63IwQ0kvvk/mldHIAD41AAJugZR9sIOKkl4ywc8BskzGUFwKE34V5RI2Xtuej4bJ1U6gJQ4u4PyxA0PUnwuRqGBYdhy0XQK13nF1nqPhmdT+/yBnNE3MrpdE+bhStAhuTnEUfEZQ6cwYmWntYzDRsOHf+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KKvBgedI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNU57e670670;
	Mon, 23 Mar 2026 15:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GLL1Ly
	3OeAkM26lTyfuK59J2i4l+t5B9XXC/Bq7VyJs=; b=KKvBgedIntUMFnLe+in10/
	ShGLogvTap51JQ+yqi0eVYJzFjLO10C9YUq0WmFwslEdPlllrjtErFvtEFChT0wa
	ZRcG3JmkJWEbl1d33WjE+EGvvA7JxSOtWikN4Nqj5jQFRQuGkE8TTZNiUnuMXzHw
	xAL3NeM6zs6ZJNbl9kSr9oAm5XudAk/BToX1ixNU2dE/iQjh0ZfX94+R/zTpLGPz
	JGOzt43Sd9p6bC1FAml/1/ZlCY8yv22ZJXSiwWsyCwv3hnVmxnIPzdXUE2erWS9q
	/M5HAjVS99cEVGC0IXcp7OzURinRW/ppiDuOTAQipjb1mbuCV15QMQDla3oeI59Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ktuq3ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:01:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NCruMC026771;
	Mon, 23 Mar 2026 15:01:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275knqtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:01:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NF1RmQ29360808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 15:01:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42E6658063;
	Mon, 23 Mar 2026 15:01:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51E1C58059;
	Mon, 23 Mar 2026 15:01:49 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.247.188])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 15:01:49 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: vishs@meta.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dw@davidwei.uk,
        edumazet@google.com, eperezma@redhat.com, ilias.apalodimas@linaro.org,
        jasowang@redhat.com, kernel-team@meta.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
        pabeni@redhat.com, technoboy85@gmail.com,
        virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
        oelghoul@linux.ibm.com
Subject: Re: [PATCH net-next v11] virtio_net: add page_pool support for buffer allocation
Date: Mon, 23 Mar 2026 11:01:31 -0400
Message-ID: <20260323150136.14452-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310183107.2822016-1-vishs@meta.com>
References: <20260310183107.2822016-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YNzfoRIt1da90gDrXm5OnayrwaK83DCr
X-Authority-Analysis: v=2.4 cv=aMr9aL9m c=1 sm=1 tr=0 ts=69c155e0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=bD6ukYfIgYhu4hH-dYIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExNCBTYWx0ZWRfXx63mzxnELWk5
 Y4ei4W1R77ANzeQcp3sM/IdvojFh1xZob0caVE4n47QoppYM048+qJ2ITChKBSjII++GBT3OduH
 FgKkCoVxgd/db9ymu20dPIn9V/fyFxZfEySwE7z7hPyZR7l5xim0s4c4dVCS+N4BKVnI0PKq1tu
 Q3VQWOb3aJI8NTpl0kqw2nVIfI4hH6gS0tAJE+FsJSdcnGj/vEHnHX9NDmGpag2zyjCd9wBIjTE
 fhXgeZWkW+1b4vyW4wli182xMcnpU+FO4qTWf9OumG1AmNrAySfCqOPfmEyY59nOzJZ2u78X1Gx
 I6XRcQvrlpEGEqFM3P2lTFIVTn9VhSM4BgUrpwdcKGDc2GQzwp7UwpwdFBViTmSGMeMWni8GmZb
 /2ruwN8yuID2OV1fr4NADUTfUJFtlWYlHu235M+UQXNnadxH8kilKOKn4kO6vGzuVpUVYQbRz18
 7oLM2n8sWdX/X/s4bvg==
X-Proofpoint-GUID: 9gD9_WOZoQLsJS8lan0dhb2SdmUj0w89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230114
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,davidwei.uk,google.com,redhat.com,linaro.org,meta.com,kernel.org,vger.kernel.org,gmail.com,lists.linux.dev,linux.alibaba.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270575-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oelghoul@linux.ibm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 034532F5E1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

I've been testing linux-next (tags later than 03/17) and hit new issues in
virtio-net on s390x. I bisected the issue, and I found this patch to be the
first buggy commit.

The issue seems to only be reproducible when running in Secure Execution.
Tested in a KVM guest, the virtio-net performance appears greatly reduced,
and the dmesg output shows many instances of the following error messages.

Partial relevant logs
=====================
[   49.332028] macvtap0: bad gso: type: 0, size: 0, flags 1 tunnel 0 tnl csum 0
[   74.365668] macvtap0: bad gso: type: 2e, size: 27948, flags 0 tunnel 0 tnl csum 0
[  403.302168] macvtap0: bad csum: flags: 2, gso_type: 23 rx_tnl_csum 0
[  403.302271] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0
[  403.302279] macvtap0: bad csum: flags: 2, gso_type: e1 rx_tnl_csum 0
[  403.309492] macvtap0: bad csum: flags: 2, gso_type: 4c rx_tnl_csum 0
[  403.317029] macvtap0: bad csum: flags: 2, gso_type: e0 rx_tnl_csum 0

Steps to reproduce
==================
1. Boot a Linux guest implementing this patch under QEMU/KVM (*) with SE
   enabled and a virtio-net-ccw device attached.
2. Run dmesg. The error message is usually already present at boot time,
   but if not, it can be reproduced by creating any network traffic.

(*) This patch was not tested in a non-KVM hypervisor environment.

I've further confirmed that reverting this patch onto its parent commit
resolves the issue. Please let me know if you'd like me to test a fix or if
you would need more information.

Thanks in advance.

Best,
Omar

