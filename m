Return-Path: <netdev+bounces-272014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNLrOEEixWmC7AQAu9opvQ
	(envelope-from <netdev+bounces-272014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:10:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 858C2334FBD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 754F83024477
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6410C3DA7E0;
	Thu, 26 Mar 2026 12:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aliasing.net header.i=@aliasing.net header.b="Y9h6/nxy"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.mr.icloud.com (p-west2-cluster6-host4-snip4-1.eps.apple.com [57.103.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC91334EF05
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.70.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526961; cv=none; b=AUB+ELpIgv9pQ1D00J4r+kub1lOdWG0DbFvRGOq+a5mbvPuCv33iS1fmD2hf2gfB7hpg62BrmUsrNOrIF1zEoHY24TX289pMVwMB+es+Oa/M1uLk/gRuIeci3B7WpSZDG90+NVSZsNgSzihK6bLFv71nyvSngz18iXMYB6V3+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526961; c=relaxed/simple;
	bh=+yGrlzp5BwsGqLDcldOQtXxixKAsL5lSNYWLykh/Mq4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XjJ+5HfkFX46Ujjw1vxP+Ra5HZcaN18IZyJkV2W8044Vc/hhHVDFogZO9JTJ6PaQCu34A278RKKuVkYVcYXKUz4yWFXy/YtIbcGDyCe4v7qow2artwuXvjaL6s/5bZy88KC50IyiHWG/dXR8UWFiS+o5TM1wXOwm/YZONjGQDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliasing.net; spf=pass smtp.mailfrom=aliasing.net; dkim=pass (2048-bit key) header.d=aliasing.net header.i=@aliasing.net header.b=Y9h6/nxy; arc=none smtp.client-ip=57.103.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliasing.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliasing.net
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id 9C25A1800126;
	Thu, 26 Mar 2026 12:09:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aliasing.net; s=sig1; t=1774526959; x=1777118959; bh=+yGrlzp5BwsGqLDcldOQtXxixKAsL5lSNYWLykh/Mq4=; h=Date:Message-Id:To:Subject:From:Mime-Version:Content-Type:x-icloud-hme; b=Y9h6/nxyK0YtF7+cdvXxFFPAcsCuxaPhUfW9mgltCjkCq89otxAR1mQZv+qGt+C3AJVmsiM/Dj7D+NRSYnXMAUj6NlVb5zHr6k6QecB37L+OuSd0dXT2tu1I0S55kXP9T64qPPRv7/NJvNvc94t16DLCuKy29laglOazXD7J2cMDZREspjQNTsoRrdQpgdURsQqLG4Kj/URnbgEyJ9beflG4dmIqjsJP0DmpJ5bpwyQHok8keZxzj/i+bQQ4tCjILe+lXq5YrWR30ErbnyiznL53n/mYUzaTSmQ9J3T83qfYcBDPI67jp0vYzBIAVTACe3hAiYvZWPkGy+7NvJ13BA==
mail-alias-created-date: 1769500909675
Received: from localhost (unknown [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id AC5D71800A58;
	Thu, 26 Mar 2026 12:09:10 +0000 (UTC)
Date: Thu, 26 Mar 2026 21:09:09 +0900 (JST)
Message-Id: <20260326.210909.43276613898103820.fujita@bee>
To: miguel.ojeda.sandonis@gmail.com
Cc: gary@garyguo.net, fujita.tomonori@gmail.com, acourbot@nvidia.com,
 boqun.feng@gmail.com, tamird@kernel.org, a.hindborg@kernel.org,
 ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
 lossin@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, yury.norov@gmail.com, will@kernel.org,
 peterz@infradead.org, mark.rutland@arm.com, mingo@redhat.com,
 longman@redhat.com, ynorov@nvidia.com, rust-for-linux@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
From: FUJITA Tomonori <tomo@aliasing.net>
In-Reply-To: <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
References: <20260319121653.2975748-1-gary@kernel.org>
	<20260319121653.2975748-5-gary@kernel.org>
	<CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: eqMS7S_G52C0wF8NsZjyMQ8O9Pmu7Vu-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA4NSBTYWx0ZWRfX9LUqgBCH9GTY
 a5ATnf9PHeMqlEKLJvYFpH5HsDQL93p0TZMRxyJqBQZcD6/VU5UxZPrOJmTYnxL8KUFgrTneMtg
 be9QwNJRNSpauaqD/ojapwE6uoagfyGOSq761WY+ZzXO8BxNot9ZgoDrIFUFQdzL+xl2aw0L5kW
 dvnhoQc1dUlzSnECg/dFiWujV2iKujHA10BoFLiu3Is1kDUlt0m70qbmUXmRP76iL5+Axj1va+p
 gXd+0HrrhIDavaaS2fJtG68cbR9bIBqnmMEFEuQjxYiVVPS2BrUL+SbgQ48qC8oWkyBXoPTlDy4
 PUBRQqi/JjLE5QfjWA0VMoyOy+V/KYL1z5dPjiatWVQBeK66s6SmVOogtGFGb0=
X-Authority-Info-Out: v=2.4 cv=TY6bdBQh c=1 sm=1 tr=0 ts=69c521ee
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=7e8LTidUJLtXHkX_rzUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eqMS7S_G52C0wF8NsZjyMQ8O9Pmu7Vu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=395 clxscore=1030 spamscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260085
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[aliasing.net,quarantine];
	MV_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[aliasing.net:s=sig1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272014-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[garyguo.net,gmail.com,nvidia.com,kernel.org,protonmail.com,google.com,umich.edu,ffwll.ch,collabora.com,arm.com,infradead.org,redhat.com,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomo@aliasing.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[aliasing.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[32];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 858C2334FBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gTW9uLCAyMyBNYXIgMjAyNiAwMDozNjo1MiArMDEwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBUaHUsIE1hciAxOSwgMjAy
NiBhdCAxOjE34oCvUE0gR2FyeSBHdW8gPGdhcnlAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pg0KPj4g
IHJ1c3Qva2VybmVsL25ldC9waHkvcmVnLnJzICAgICAgICAgICB8ICA4ICsrKysrLS0tDQo+IA0K
PiBUb21vbm9yaTogYXJlIHlvdSBPSyB3aXRoIHRoZXNlIGNoYW5nZXM/DQoNCkFja2VkLWJ5OiBG
VUpJVEEgVG9tb25vcmkgPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+DQoNCg==

