Return-Path: <netdev+bounces-281360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFsqBaBu72mHBQEAu9opvQ
	(envelope-from <netdev+bounces-281360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:11:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD3B474165
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E076430598D8
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF523D091F;
	Mon, 27 Apr 2026 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gDofzOO4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U6HX0qwO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833C3CEB9D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298446; cv=none; b=jO3X4HX2owIoA+xjERzrs8oaCrTf6hA/wxKBbyoDLb65XpVaU6ZrxK2yxjODtQRel7O4/+4VBiik7QuLEWzId7z2SL2irvEhMlRn6a8veGQcdSEgIPZE/xPrw9pEjYnIrwVFrhiKPJqZLUFNrXZTmrgxWBchtn1PpmUWKWNMV3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298446; c=relaxed/simple;
	bh=bP6HA6pZjm7hEbY5JnHa5ksDdA+WtVqVV3UGDdamgPQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FVV8vvx2LT33b+9HJb8CjK46kmcj0+ijST45mYFztB6fhBaYppqAhr6+VLt1m3ukDWNwvsWLJXDPNX/ZNu8XB5ywOKcn+YR5UpSkTl+ajemhjSeYMXnVwQ2T8HK0x5ULXrmqEeZP0ns6L2rbl/9zyH26P9y5c1OcYWX6Y/T7F8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gDofzOO4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U6HX0qwO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RDtvQP665792
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=e+qIoID6Yg+3aC2B7pB4TK
	5iyob/h1HJrqolQGz2E9U=; b=gDofzOO4I8TAtexZFG8UXhv9/zU/JniCYKUtYn
	vzGfjO8i2ThDssKjDIPSCX5J6b4Si6UrGgefdw4u/iliYq7x9S0d5tNnIh1hcIkM
	XAjU5Pe8+FnUSyzOn0DmzPaM7bg6FdPt9NqW1eJ/aXng2owDtCLkyN+icVZ5N/Vm
	FZcUeyuewHSbouCdrxZEz8BG76/riFZvRdg0W0DgSCV2tenjfwDY6D4QeLdxxDOr
	bey5Dg4+fzRPAJKtjYzMTQYlWpbKiAbptL+33CD5Y+bS0yhNmuuqdbyTYRHNY//d
	ylXVmeWGTxjyetxRp2mmbmzaGcAcjzN7+9avrvYuzyZDUqoA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt30n1pag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:00:44 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-56fa1c1ae6fso13301030e0c.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777298444; x=1777903244; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+qIoID6Yg+3aC2B7pB4TK5iyob/h1HJrqolQGz2E9U=;
        b=U6HX0qwO1f6gyrsNHVhxwrH4/9bz8LgTGatI+2d5PgbMQHcBJN3t1jwIdFf5Q3lNkn
         +voXcVF1iajf0daiVSDJ6FvGHxcbKqHWuujLS64UAhKU96vQcJhACm6uLxunYwUxhpLI
         hrwq4Z2DvAYXp1ANgpylDThBvQ6Ia2NTatvjtcH72D6B0aaSKr+OdbhLgtTsfDs4uXED
         vSqxsM6U6C9XdnddkiQ/lzSaYYJJM4+HyhbU9tSdLJVV6pNfgpmzjK8E3D85dzx2MSGJ
         d8/XOuQlEc07YNY9j2IIjFwMdjEvzzCtTzeB3jaznno2cWQ8qPjdFUM/oo5Vhsi5JPuB
         a39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298444; x=1777903244;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+qIoID6Yg+3aC2B7pB4TK5iyob/h1HJrqolQGz2E9U=;
        b=FABOm2Zz1GcUveTFbXgOTbKfHvFNR2ntrel390Fs035StqX4h93pvisGxN+k/jaF0d
         bQYK1XlKXv5iPaQdBdzbdyxI14C+ZmrDWLz4Atix1NpMCiSiqnbyCspAh3fbRHxaLfcH
         FF6YAON5mJX/bu7KnJ7e8bIZKxBd0yt8mBLMzeIfj+x+hItP3hWBRSbKV5WxGKxIQhC0
         axO2QG96bvpJTw7tGljQdFpXyvtvgA/Dgu5+nW0o0pjQWL6t3PMSW4uwQJJHm7k7VIVe
         5JWxRw2OSc0Sk/jr5iqb+3o2Uh8AidWh5XdObzDYe0bIuiKzITXlDMpiqaQOTMPB90SL
         42lw==
X-Forwarded-Encrypted: i=1; AFNElJ+WLK9CgFvGEZRYd9bR2E9EyuA1+K2u7pvGOKNMmh6+tOKriYJb6MP9MWfi6UpuCwnvtsSSiuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynYICphPLcaFuVKKIFr6y+DWrLKa9rk37pxo4JMcko5CkI5ux1
	NbVH9HnMLnbpkiWnPpmWoZbCYoovizmy6qjQZfuNb81QWO5UpE2kKBQvYul2+eIRoEE8CikhOv9
	b2PSCztWlsVXKjotXKxswbc7n8uUEsWJ6tlPZ43RpGtpDeRMnQzM9HP9yfA7VHUzL494=
X-Gm-Gg: AeBDieuVV16CVf58gEOi8eWwLWKnd6Gcv6wPxsJ5hCP9q3yaN2q7rpoycSSr8hcBct4
	dT6jl6X5QbtxdSR2BtxJ9pTQSZgAu/JQbCIAlT8BAu491k4jVyuc+L93H4D7nC0hcWI/VlHSyzl
	4y5w48ctS03QQRWLc30OrgxcXcyU7DQexZQ5UegGRVSqvuHx+cUTKzsFuIH3LNysmgzhjA+A/DC
	bdbZ26vb1yhBVtjfyxdk240ofxB/KAkBGlFpmv6psaSrZtsRY6l9MCINQm237RyBl3e2dD8RXdp
	ImIpaDJber1mPdtOGo22M/Y364DwWVEfZNf8QmYlPiRWN3AWuJfKxd9TbH5Iwhw8gzQZake+MLx
	74+BmbfuShPBRmr2tINtKNbFx5aJm8I/+VFrHJkbpLrjvTf7GYrgU4/MQVq4MeA==
X-Received: by 2002:a05:6102:b10:b0:611:82b:a590 with SMTP id ada2fe7eead31-616f73f6ee1mr21753644137.25.1777298443191;
        Mon, 27 Apr 2026 07:00:43 -0700 (PDT)
X-Received: by 2002:a05:6102:b10:b0:611:82b:a590 with SMTP id ada2fe7eead31-616f73f6ee1mr21753575137.25.1777298442558;
        Mon, 27 Apr 2026 07:00:42 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:85d0:5328:3f13:c3e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc558f2sm626849135e9.1.2026.04.27.07.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:00:41 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/2] pinctrl: qcom: add support for the TLMM controller
 on Nord platforms
Date: Mon, 27 Apr 2026 16:00:28 +0200
Message-Id: <20260427-nord-tlmm-v2-0-ade8e0f3d803@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxr72kC/22MwQ7CIBAFf6XZszRbRIqe/A/TQ6XUblKgQiWah
 n8Xe/byknmZzAbRBDIRLtUGwSSK5F0BfqhAT717GEZDYeDIJQo8MufDwNbZWnY/qVadJWqjJRR
 /CWak9966dYUniqsPnz2dmt/7r5IahkwoKUaBqFvEq4+xfr76WXtr6zLQ5Zy/bOd6sqkAAAA=
X-Change-ID: 20260403-nord-tlmm-b5878960cec6
To: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=bP6HA6pZjm7hEbY5JnHa5ksDdA+WtVqVV3UGDdamgPQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBp72wBv1/nO6x/9nLQf3pM5oeNQ1lnuKL1EZSMA
 RJ1XvrHqFeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCae9sAQAKCRAFnS7L/zaE
 w1M3EACON20QyLwDiCoNEIMTZZVSwoXpmGSDFS4F949jGpccdICoTjVZLof23FFgmfG5U7OGZq9
 aZxhIcKe4eck97XE7sc+urLbgjbXLapWv1Wm0E2D18hpHJcRcfFW1/7BQdRyfwcpfbUJ2egRgjA
 jt4VxooIw6MGU9yIBwPWx09kfC63R1jvE4VkEBw3D+Y9sWcHHxbBSws7SDz+gM5+xMnms4dHJRl
 dZRDntz795lNy/0G4RRYpUEFMn90dAHhq1A6mqRAfZkE+P39PNUnZoKQ+06RrunmedmynTfXBcg
 +zTUekOyJ4jAQ7bVqjOys/2YJzyihVo978XZ2g52JQloO60pNLw4C0pmeUnF6DEsvFqOGfwvmzc
 Gv6B4r9Bn8k6KOwEPH1D+fJDQhn86b98nWdcJ6D/kO2Oe4ITDIKePPtNlFeFqAbcpTE1Z3foVmO
 l8lfCemf7Hh4hQGW3aZ/NW7HGhXy57QJMvYclpnNSYJX/aZ+6iUwprC7eCP7NP7W5TcPSgD6gXA
 6Ekir5wf5gbkl4AoQWxuyNOWFwPMLWaUobbl5MPe7h67CN5CaY+X0gMzCHF3KNUELE91/KiF9sP
 eT4sos/jzfrQvjyAVX9g5ILPuh4mNIx9bVekKOOeYMRftpgi2M/YoO6uv2SlUC9ZtUnJvP2XA9x
 BN9CTFbIhVRgaDw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0OSBTYWx0ZWRfX/KsG8tFb6SLP
 SvqQ7lu00DjVDDWDKtwbRNkNtumTl+5C65Ug79hZQhgrNOtMkGKSkDkbsleM4SkMlZ/SbMJkTnS
 rdgnogWJFimfT4ccckbKdm9mZMarXkPxtuWYc3QPSN4U2sCp/9zp0e1Xw68eluuxQXlDFh2bhA5
 LrRzi2gbKUDnTllZ1u+StP/gO8q7V2YHRXC8xf5O/zg+Eh1E+9fd2l7+qPjVcmFKTmqFWLAQTr2
 8cwdx7wWjzBP4nBCHGRelWgutqdWFx996ckEfhXUwVq3ryR/Ofzp1+Szxw4bjLfqlizAX3UM1Tj
 f3s+WQz4K7q0MY8CsypDMDkQLhdrGHd0JxYu5Qi0SzerpaWocF42V5cw6q7PRv5I6+WtuFEVmE/
 stz9edAiF4olZLumzolQh54TzAbA2mLY0hW1w1s8Tr3TdUu7Yy3Dbx0xVT7G9wF2YMSEcPz4RHp
 GdOxZoXHnh8z7M53aQQ==
X-Proofpoint-GUID: Car8SiK8mZEV9ZkfbWdUaPk-r3IatYJz
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=69ef6c0c cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=qGPvtIwEQInV9_J8vEUA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: Car8SiK8mZEV9ZkfbWdUaPk-r3IatYJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270149
X-Rspamd-Queue-Id: BDD3B474165
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281360-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,oss.qualcomm.com,arndb.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

This adds DT bindings describing the TLMM controller on Qualcomm Nord
platforms and implements the pinctrl driver.

More info on the platform here:
    https://lore.kernel.org/all/20260427003531.229671-1-shengchao.guo@oss.qualcomm.com/

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Order Kconfig entries alphabetically
- Fix the regex for the pin state pattern
- Fix maxItems for gpio-line-names
- Drop unneeded line break from bindings
- Rework the pin function naming to make resulting state entries in
  devicetree more concise (drop the line number suffix)
- drop .intr_target_reg from PINGROUP()
- fix values for interrupt entries in PINGROUP()
- drop unused SDC_QDSD_PINGROUP() and QUP_I3C()
- drop the arm64 defconfig updates from series
- rebased on top of v7.1-rc1
- Link to v1: https://patch.msgid.link/20260403-nord-tlmm-v1-0-4864f400c700@oss.qualcomm.com

---
Bartosz Golaszewski (2):
      dt-bindings: pinctrl: describe the Qualcomm nord-tlmm
      pinctrl: qcom: add the TLMM driver for the Nord platforms

 .../bindings/pinctrl/qcom,nord-tlmm.yaml           |  184 ++
 drivers/pinctrl/qcom/Kconfig.msm                   |    7 +
 drivers/pinctrl/qcom/Makefile                      |    1 +
 drivers/pinctrl/qcom/pinctrl-nord.c                | 2843 ++++++++++++++++++++
 4 files changed, 3035 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260403-nord-tlmm-b5878960cec6

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


