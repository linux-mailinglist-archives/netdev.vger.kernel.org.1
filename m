Return-Path: <netdev+bounces-267268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHGGOBtys2kEWQAAu9opvQ
	(envelope-from <netdev+bounces-267268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:10:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D78F27C8B0
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3ECD30804D3
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B9533EAE6;
	Fri, 13 Mar 2026 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="O/jRRCf9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1133DEE1;
	Fri, 13 Mar 2026 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367735; cv=none; b=nKBhl32q1D3bx6pVL9AoWDuf2RGRzjZpg3LHOJrlsaZ4JrXjFGvTeT5Hw6fEsQsUuN3tL4Ul5EXyWOiEZdwaTNCKDiJzHMADjpVJ/roNPSLZzLduw4Oo6no7gLiXyJ8R8C7uMS0yAEL0v4tlHUzRNF74frHsKo4D5xvJiA6PPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367735; c=relaxed/simple;
	bh=iG9eoykzXKh3xkb4QWpnmXISxnpmcfVmw5TdguJu7C0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abeXVdS00dOwZKzO9Epb1CjVPfAficQehC6E614y/e2gWEcgjS6Pg5Sr3pyvdQUQvniahuKcbH3BikG5ITE5bSvMqo6IstjjPGIRF2mofZKA+yjdiNbzhuvsvi73w5nuadqAmTF1ikNR3gBofFLN0GAVFdUWknamAa+UArsvljE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=O/jRRCf9; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62CDR8pM2347389;
	Thu, 12 Mar 2026 19:08:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=6
	SLus9YKMKbkG/Gi3bNPWa4rdN0TeilpxFrK1bpwIxk=; b=O/jRRCf9JEfSomcPT
	HblGwbdFBwQSDGincCAm5y7SwHtPfzFnmahlZdMxcpJymaWlyYdfg8mOUmIhOwXR
	otpgoWA+qptu6892lwdYIUMSASDBLZMr6Zi+QK104hj4iie+n2fNNRym0jYr9oJJ
	1vhalK6Q5mxsWXvuhddnNpfjlQtIsUQA73KCNmKYMNRSFrswVM0JqMGEQZsrLYWZ
	VcZi+vxitN4fvz9b9qbWF7/AWFDkhxJJSXokxtM7SvVYG6o2qJQuKu4RJSNiUQwO
	2VUF84uaTTZ7z7D2ME2Eu6qQJdB2p7VuME9VjVDnLHUlLKB7jNhETJhxQHdp7kF9
	POmaA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4cuh6kkepa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Mar 2026 19:08:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 12 Mar 2026 19:08:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 12 Mar 2026 19:08:36 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 553693F705C;
	Thu, 12 Mar 2026 19:08:32 -0700 (PDT)
Date: Fri, 13 Mar 2026 07:38:31 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Simon Horman <horms@kernel.org>
CC: <cjubran@nvidia.com>, <matttbe@kernel.org>, <chuck.lever@oracle.com>,
        <shshitrit@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <sgoutham@marvell.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <saeedm@nvidia.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <pabeni@redhat.com>, <donald.hunter@gmail.com>
Subject: Re: [v3,net-next,5/5] octeontx2-af: Add support for loading custom
 KPU profile from filesystem
Message-ID: <abNxn9fGPNyKf1_6@rkannoth-OptiPlex-7090>
References: <20260309024619.898211-6-rkannoth@marvell.com>
 <20260310172100.890161-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260310172100.890161-1-horms@kernel.org>
X-Authority-Analysis: v=2.4 cv=aLz9aL9m c=1 sm=1 tr=0 ts=69b371a4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8
 a=-_xwQyW8Ut5iv-1M7J0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: FRnnY3J4DRAsA8Xbpe9YLjTQzuZEi-jl
X-Proofpoint-GUID: FRnnY3J4DRAsA8Xbpe9YLjTQzuZEi-jl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDAxNSBTYWx0ZWRfXwHZx0UPPH1yk
 FKrO1SwkFJ6GYoQNmlyMEQrVdL6PnfhW01KuRmqUy9VDD0VXL2PQyGGMbgv0FiVr+U2CTs4u030
 cllvYwsWs4CVNQO5S7z1deHrzLXfR62R+Gyt28GG/72xShL0m9D7AAZWBHjj3ZBf4zbjxHCo+vq
 +ZQMuawiJ9aerOFMu66OESNVoTzRTg7aucGykWBAGsg9GBBCKekXaFvj/fW/3PFuv0TeJEEsDgc
 ZyjPUnFwHco4Hg27eWJPBJlIBvPHm27DLOfybhkhWmht3CJdzKibqi7gkmmlS2JL1Vpjp6E4KuI
 J2nYtif1Gvkfx6t9K3Si1rldQs8+Uvwr9Tm/mRP5HONhe9Pb0FF8fm8hjQvh6XXHlv1cJ/U128e
 LNoVvIB21h7o/8DDzKxxVYpHB7BGf+QGlBWRxznVDS14ez9AS92erevHhk35o1LNltp2okLEZEV
 3pyJN/hsNr5JkwlK9jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_03,2026-03-12_01,2025-10-01_01
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267268-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,oracle.com,vger.kernel.org,marvell.com,resnulli.us,davemloft.net,google.com,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5D78F27C8B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-10 at 22:51:00, Simon Horman (horms@kernel.org) wrote:
> Could this loop overflow and hang the kernel if firmware specifies more
> than 65535 entries?
>
> The loop variable 'entry' is declared as u16:
>
>     u16 kpu, entry;
>
> while 'entries' is an int:
>
>     entries = fw_kpu->entries;
>
> In the from_fs path, 'entries' is read directly from the firmware blob
> without capping it (unlike the !from_fs path which uses
> min(fw_kpu->entries, KPU_MAX_CST_ENT)).
>
> If a corrupt or malicious firmware file specifies fw_kpu->entries >
> 65535, the u16 variable wraps around at 65536:
>
>     for (entry = 0; entry < entries; entry++)
>
> When entry reaches 65535, incrementing it produces 0, which is still
> less than entries, creating an infinite loop that hangs the kernel.
>
> Should the code either cap entries in the from_fs path or use an
> int-sized loop variable?
Hi Simon, I made some code changes and inadvertently missed addressing this comment in v4.
Sorry about that—I will address it in v5.

>
> >  	}
>
> [ ... ]

