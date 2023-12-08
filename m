Return-Path: <netdev+bounces-55468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDE880AF8C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C33E1C20B66
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 22:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC59B59B50;
	Fri,  8 Dec 2023 22:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="rNRMo1EI"
X-Original-To: netdev@vger.kernel.org
X-Greylist: delayed 3600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 14:15:33 PST
Received: from rn-mailsvcp-mx-lapp03.apple.com (rn-mailsvcp-mx-lapp03.apple.com [17.179.253.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31243118
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 14:15:33 -0800 (PST)
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by rn-mailsvcp-mx-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S5D00ZPZ9P8W320@rn-mailsvcp-mx-lapp03.rno.apple.com>
 for netdev@vger.kernel.org; Fri, 08 Dec 2023 13:15:19 -0800 (PST)
X-Proofpoint-ORIG-GUID: BYy3LuLylsy9hzH0TOyudeXd5dRJTO66
X-Proofpoint-GUID: BYy3LuLylsy9hzH0TOyudeXd5dRJTO66
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619,18.0.997
 definitions=2023-12-06_16:2023-12-05,2023-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 suspectscore=0 phishscore=0 adultscore=0
 mlxlogscore=770 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060141
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=wt2+gviYgwNsi9SeCAvj4k9mnujLVckHvxW1RAVOtSs=;
 b=rNRMo1EIrcC94+s5q4F16cSiEjeEDX6LHsKvxe/WpqBkNXQy3p9VwFh+v1n+o2OpIJ8r
 eioBSh+Mu410GmiwN3WKN41OAUJ/OFN8/dvN2Q22ix4rcMfbZoKuCO88oVJ+saH6bDPL
 cyn1oovfVDygmGzqKITnzaSdh/NsdgH3g82/bLuJ94izMP1IpZkEhwjwqzFQryeoLEjF
 ym/Woaz60YLji9CRdvNKCflBc4AcOvay1eeMqKeUA/LBODEVDMq52apjTjQjfthJaQiv
 /Z4U//oIAS6EBWnwcDtaAKwm/OeZoa7J9qgqMwftt+DOQ6lry6i7k7GtrtYuczHkjnTZ LQ==
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0S5D0059C9PETUX0@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Fri, 08 Dec 2023 13:15:14 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0S5D00V009CO3S00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Fri,
 08 Dec 2023 13:15:14 -0800 (PST)
X-Va-A:
X-Va-T-CD: 885f49186fe607d02917e8b1ef4f4a67
X-Va-E-CD: fbbe1b776bd31a6659ba08ec7c18a73d
X-Va-R-CD: 8b8a8f72165e811c854d5a51d15d96e9
X-Va-ID: 77a4ed98-8d8d-4e03-9945-7cbd77642190
X-Va-CD: 0
X-V-A:
X-V-T-CD: 885f49186fe607d02917e8b1ef4f4a67
X-V-E-CD: fbbe1b776bd31a6659ba08ec7c18a73d
X-V-R-CD: 8b8a8f72165e811c854d5a51d15d96e9
X-V-ID: 1aca8bea-f969-4d1a-96a0-31b2c759f2d1
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.619,18.0.997
 definitions=2023-12-08_14:2023-12-07,2023-12-08 signatures=0
Received: from smtpclient.apple ([17.149.239.4])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0S5D00PCU9PE6100@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Fri,
 08 Dec 2023 13:15:14 -0800 (PST)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: mpls_xmit() calls skb_orphan()
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to: <9F1B6AC3-509E-4C64-97A4-47247F25913A@apple.com>
Date: Fri, 08 Dec 2023 13:15:04 -0800
Cc: Craig Taylor <cmtaylor@apple.com>
Content-transfer-encoding: quoted-printable
Message-id: <7915A22A-F1ED-4A5D-AC2A-25D0C05ECAA0@apple.com>
References: <9F1B6AC3-509E-4C64-97A4-47247F25913A@apple.com>
To: netdev <netdev@vger.kernel.org>, Roopa Prabhu <roopa@cumulusnetworks.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)


> On Dec 8, 2023, at 1:06=E2=80=AFPM, Christoph Paasch =
<cpaasch@apple.com> wrote:
>=20
> Hello,
>=20
> we observed an issue when running a TCP-connection with BBR on top of =
an MPLS-tunnel in that we saw a lot of CPU-time spent coming from =
tcp_pace_kick(), although sch_fq was configured on this host.
>=20
> The reason for this seems to be because mpls_xmit() calls =
skb_orphan(), thus settings skb->sk to NULL, preventing the qdisc to set =
sk_pacing_status (which would allow to avoid the call to =
tcp_pace_kick()).
>=20
> The question is: Why is this call to skb_orphan in mpls_xmit necessary =
?
>=20
>=20
> Thanks,
> Christoph

Resend in plain-text. Sorry about that!


Christoph=

