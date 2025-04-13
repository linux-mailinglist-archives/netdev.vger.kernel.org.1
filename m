Return-Path: <netdev+bounces-181944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3555A8711B
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 10:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416957AEC07
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87901547F2;
	Sun, 13 Apr 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unidef.net header.i=@unidef.net header.b="I6oOm7PK"
X-Original-To: netdev@vger.kernel.org
Received: from mr85p00im-ztdg06011101.me.com (mr85p00im-ztdg06011101.me.com [17.58.23.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7729522F
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744534304; cv=none; b=SQcbuGJXR9ik1exAWW3O0MG07JnQQGIiRJNJRLPMyXoErB7tKg2GoVfcUgOAdfXFkWi7kx5XnoyZ8+e7Bz/AylAm19yjAGvwxjjq5bEwlQRVJK+oDavP2wcRxUj18jUEXMRrnMGhR02log9vut5Kn65jKxW1KCarFJ4XTH5IrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744534304; c=relaxed/simple;
	bh=N7qUEkJ8ZX+io23MYSOp+PfOw/WMnVUyN9Ts+IJ0YFE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=L83Uiw7L8im2ayOwcdTY8K7D8z7mcrm35pQ4IxfzOkLq7HN65EAcOG5vo5HmkvvvEs9Mv/G6w95CP8Hw81Q3zxfTp0woXw6O5tY2R0Ma7GG6JKp5PLgA6Uz+5kq/Mh4e4OguNHaod7ch1yCCkdC6oE69oJd/zPcYD8WtbW7DKTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unidef.net; spf=fail smtp.mailfrom=unidef.net; dkim=pass (2048-bit key) header.d=unidef.net header.i=@unidef.net header.b=I6oOm7PK; arc=none smtp.client-ip=17.58.23.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unidef.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=unidef.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unidef.net; s=sig1;
	bh=N7qUEkJ8ZX+io23MYSOp+PfOw/WMnVUyN9Ts+IJ0YFE=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To:x-icloud-hme;
	b=I6oOm7PKZBG4kV31owXljJOv3qHQfLgI5uvgjWCPfA4404r+XXwSu8dzrTKeERtj2
	 y4kvVqZktf3AZS30qUoT7cYFppBFKqpPJg7juPqnJONQBogXpWveNZx3VACgPZ/P6Z
	 bFa5JtaEIhfWDTp92ulqcThwq4ZOEn++YVJa0emGqLClsgJzMgonfTVAv47hTf+06z
	 utit946CWE1zWuTQfpHl1rl0HdZNUgtCe1dvuxxZiKiIz5bqxy6Q7GnL/RSI5kEVlR
	 d+dtr3YgjacS0ehXRca9Ge69F3dCIq4Z4EKGXeQPZK8Va2Y+IlY6qJ9zl53gbeCaeW
	 WtSlK2e0dIIpQ==
Received: from mr85p00im-ztdg06011101.me.com (mr85p00im-ztdg06011101.me.com [17.58.23.185])
	by mr85p00im-ztdg06011101.me.com (Postfix) with ESMTPS id 90293DA013D
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 08:51:40 +0000 (UTC)
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011101.me.com (Postfix) with ESMTPSA id DF112DA0088
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 08:51:39 +0000 (UTC)
From: Jon <jon@unidef.net>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Is there a way for ifconfig to return wan ip addresses?
Message-Id: <711321ED-4C88-4006-8612-B7699E838481@unidef.net>
Date: Sun, 13 Apr 2025 01:51:29 -0700
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Proofpoint-GUID: vwDBcX6NShAjai-UNfajUXINvNlNKIYd
X-Proofpoint-ORIG-GUID: vwDBcX6NShAjai-UNfajUXINvNlNKIYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-13_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=17 mlxlogscore=70 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=17 adultscore=0 clxscore=1030
 mlxscore=17 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504130068

Maybe by interfacing with the router?

You can somehow send some kind of query to the router using router =
protocols, and it=E2=80=99ll process a return packet with the wan ip =
address I think, per wan ip address attached to the router

Or you can flat out make a standard for all routers to adhere to when =
returning wan ip addresses, along with others stuff like live latency =
checks or some kind of network security module

Or someone awesome can implement some kind of protocol or handshake =
method for linux router distributions to return the wan ip address =
directly from the linux router

I think my packet thing will work

You can send a packet through the lan network, and it should return the =
wan ip address, I think, just through multiple layers or something=

