Return-Path: <netdev+bounces-263242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOq8Ae/0pmmgawAAu9opvQ
	(envelope-from <netdev+bounces-263242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:49:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7112A1F1C60
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6330D30233DE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60947DD49;
	Tue,  3 Mar 2026 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pbh5f+N6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E347D94B;
	Tue,  3 Mar 2026 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772549283; cv=none; b=I6+HXm7fVDSz6EuL0puPoBgOhx/vybyhWd/axdvg7dMwNWFS1V74234gO357TprcorlBUK9pTg+YElEOVt6zLY43TaqHldrBBZngFQ9PxIAMtoZSFfyl+L/GrBH17LHqNPLLM8o26TtR2pffwXpe4W2Jhj8ZnIslbRmkCcejUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772549283; c=relaxed/simple;
	bh=QnHHRj1fZrwIMzf7+wSQ98EmiraRvhjneiHYOKoyUP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kptvMYoo0S/Mnxsr/4sMFmz006iT3PHsx/GRsH5QqhFTM71WM6U25H4a76cXDj62i/YLzpWpJjrX02qngnh8qEyVPbg58bespJJp48tlKiX4ZiuXkRYVGSNFu7Ox96j5hEFnKNxdf9Hq43VOz5n8UEZHKznGnM8U4aQc1OXkmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pbh5f+N6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623EEswD589479;
	Tue, 3 Mar 2026 14:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oFoTCX
	y0/GyltE0aycDntxY7McweJqwoNivGdSYPi/A=; b=pbh5f+N6czdclUjLM9Lfyc
	wosgo4+ycgpHurPUlnsmJzVUdNW3gvDSeOod8TWh1Ue6OKtLhWjRQEo2KZL/l/vt
	Xac5o1KdqodNCKu3/nLD2OYLFyRhmFh6WjyEjeHGu9zOaGuFSX6rudBw+sYDWxLl
	v6LphinsEMkobdWseN7hVZ24oe8YDExqE5IGJ5btQX5n5dxiWxrVJXffTOwLDvT5
	bfZgwc8lzkVS0soPLAdhsbQkVUvNoNY0lyx5o4la1sba+gmXnavyRNXE+VBuLTfk
	ujtaTHILYBUJVUHUQfKHzXaCv0ZYpQVT9DH+Hm301nIEK56amOJoe4aSfAahqEKQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmk6t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 14:47:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623BPUIF027658;
	Tue, 3 Mar 2026 14:47:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjag2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 14:47:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623ElvBw59638104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 14:47:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 112102004D;
	Tue,  3 Mar 2026 14:47:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E95262004B;
	Tue,  3 Mar 2026 14:47:56 +0000 (GMT)
Received: from [9.52.217.119] (unknown [9.52.217.119])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 14:47:56 +0000 (GMT)
Message-ID: <813dafb4-36e9-4e48-8909-fc1b2c1d3b47@linux.ibm.com>
Date: Tue, 3 Mar 2026 15:47:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dibs: change dibs_class to a const struct
To: Jori Koolstra <jkoolstra@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "open list:DIBS (DIRECT INTERNAL BUFFER SHARING)"
 <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260302163103.3324304-1-jkoolstra@xs4all.nl>
 <2026030246-savor-hardener-6102@gregkh>
 <b4804b53-c25c-485e-8cb3-9ade70a6f625@linux.ibm.com>
 <1787125475.222946.1772544235267@kpc.webmail.kpnmail.nl>
 <9354017b-36d6-4001-a28b-a3f777506909@linux.ibm.com>
 <1277375914.227884.1772545668781@kpc.webmail.kpnmail.nl>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1277375914.227884.1772545668781@kpc.webmail.kpnmail.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDExNiBTYWx0ZWRfX/uk8ZyG+iZSu
 UCK543Y0R9mSlCGT3ErvfjmIPuX1SuFZXGqfWwfLhkNAyPvnVcrRWvg5K8CHlDqdT21Q37hkL8b
 +f0sp9PdZ46TSMrbT79B91rfcta15Rx/RB7241AvVDYq3pQznXwGCOrRhsPVIzD4T4fId2Uf8g7
 ezHd/EoByT5XcWFpAeTOJW3HU3r+s314S4bkmnYjiCHycAiuxpe/mBuk2iTJbwBD/+4mTj3Kc2j
 i0F0KqZi0sJiQCSTdb7A1gyfNroxNg5MtkR5wfOdQM3zwh1nwFy6tKDAlujVgUdMpuHf3O32ixE
 KFfT8z1lL+slesrwCqOmMDzpdP1kJO/HLb8xYf6HDYO9xkvbTmvGC5T9zxEz8r3L5OB5MI0aH8T
 wu827TQiY7JwqhD4cpErUteoWBnRRNjBIRs4TfFT7KcHkrG5RBDyv3HfdmdzuOkgNLOhurfRXEt
 Dbrr5P2yuUyuaCeiOew==
X-Proofpoint-ORIG-GUID: Py7xApIe6hsbPuExU3dhJ6MpGSIz-upv
X-Proofpoint-GUID: Py7xApIe6hsbPuExU3dhJ6MpGSIz-upv
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a6f49f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=T3uTMoZwtbrLHnHwW6wA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030116
X-Rspamd-Queue-Id: 7112A1F1C60
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.ibm.com:mid];
	TAGGED_FROM(0.00)[bounces-263242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl,linuxfoundation.org];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 03.03.26 14:47, Jori Koolstra wrote:
> 
>>
>> Thank you.
>> Would you mind sending a quick v2 with the link, so netdev maintainers can take this?
>>
> 
> Sure. How does that work with the reviewed-by tags? Do I have to add them
> manually to v2, or ... ?

Yes, that is my understanding.

