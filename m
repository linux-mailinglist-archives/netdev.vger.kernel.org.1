Return-Path: <netdev+bounces-55464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7F180AF62
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AA41B20B05
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F2758115;
	Fri,  8 Dec 2023 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="Trs9UdVg"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 3600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 14:07:09 PST
Received: from ma-mailsvcp-mx-lapp02.apple.com (ma-mailsvcp-mx-lapp02.apple.com [17.32.222.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77381BEA
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:07:09 -0800 (PST)
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma-mailsvcp-mx-lapp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S5D00CLM9BVQH00@ma-mailsvcp-mx-lapp02.apple.com> for
 netdev@vger.kernel.org; Fri, 08 Dec 2023 13:07:08 -0800 (PST)
X-Proofpoint-GUID: FUFF0boUFx5kcfWjg6Sc1wSaMbWkhzBG
X-Proofpoint-ORIG-GUID: FUFF0boUFx5kcfWjg6Sc1wSaMbWkhzBG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619,18.0.997
 definitions=2023-12-08_14:2023-12-07,2023-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 mlxlogscore=625 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=from :
 content-type : content-transfer-encoding : mime-version : subject : message-id
 : date : cc : to; s=20180706; bh=Dm508fVBJoP3f2RwtWsCGCH2wp+FIsxCn4bmoydseAM=;
 b=Trs9UdVg1KBhUKsPrUQ0yRJPtEkB7r9WY0S8h+201MBpPp28Bx2t7lvDE7yYLeN4Ic/o
 NO0DsNWT8V/fVARn+yLWKuzI+xXK3f/7wUgvEgeK5Enov1dZfGklGPtMutt9jzpWcMap
 pfnM3ZhQJkO5amA4D/2jV2/dtKh4ncImMeUFQOzdjwkscbL2N6DkoNvS55ZgYIwJAvhC
 1BP8qpmKTUxh1SAtJPybRDAYD0tmj+nIbLk3ubTWA5JfgbTpo454WWScLTaiJwfuYMLH
 OVlpOkfiyeZp1VEFB8V1cZbm7f6VvBSyCVQj7jHKx/82X/snO2QG8KWnlv95oHYY9/hs qA==
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S5D005ER9BVTUG0@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Fri, 08 Dec 2023 13:07:07 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0S5D00F0093FA400@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Fri,
 08 Dec 2023 13:07:07 -0800 (PST)
X-Va-A:
X-Va-T-CD: 885f49186fe607d02917e8b1ef4f4a67
X-Va-E-CD: b23bedd0ab5cf2b394606a3c6f9d645f
X-Va-R-CD: 2486f0c6f75e1f087ebf3d1a9f17fcad
X-Va-ID: b5018b07-a0a4-468f-89e2-c348cbbfbd11
X-Va-CD: 0
X-V-A:
X-V-T-CD: 885f49186fe607d02917e8b1ef4f4a67
X-V-E-CD: b23bedd0ab5cf2b394606a3c6f9d645f
X-V-R-CD: 2486f0c6f75e1f087ebf3d1a9f17fcad
X-V-ID: e4a807bd-137d-48bf-92dc-5ac55e676da5
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619,18.0.997
 definitions=2023-12-08_14:2023-12-07,2023-12-08 signatures=0
Received: from smtpclient.apple ([17.149.239.4])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0S5D00P259BV6100@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Fri,
 08 Dec 2023 13:07:07 -0800 (PST)
From: Christoph Paasch <cpaasch@apple.com>
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: mpls_xmit() calls skb_orphan()
Message-id: <9F1B6AC3-509E-4C64-97A4-47247F25913A@apple.com>
Date: Fri, 08 Dec 2023 13:06:57 -0800
Cc: Craig Taylor <cmtaylor@apple.com>
To: netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)

Hello,

we observed an issue when running a TCP-connection with BBR on top of an =
MPLS-tunnel in that we saw a lot of CPU-time spent coming from =
tcp_pace_kick(), although sch_fq was configured on this host.

The reason for this seems to be because mpls_xmit() calls skb_orphan(), =
thus settings skb->sk to NULL, preventing the qdisc to set =
sk_pacing_status (which would allow to avoid the call to =
tcp_pace_kick()).

The question is: Why is this call to skb_orphan in mpls_xmit necessary ?


Thanks,
Christoph=

