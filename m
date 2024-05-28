Return-Path: <netdev+bounces-98419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D0C8D15E3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C337E1F22B7D
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8572C13C801;
	Tue, 28 May 2024 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHD8dPJr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E5A13C67E;
	Tue, 28 May 2024 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883792; cv=none; b=BMqGZi1vLO/aULWsg3aAu70ahzWNXpTigLEOiJU8FDxXErJ0UUFLZFBjzBune0QxkNGmAGyBHz8Xs7woOMw9MzaALVIaFSaxxsqM/yphsIBr14Lk9UywdrxRowJLTZiHvWLS81vWcjptp560rKB0b592RbYCUsKlNZuZGco4GDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883792; c=relaxed/simple;
	bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=exDomITBjs7JY0UGtNIMTc9IY+IuKAiHf451rfB4oD6mvm5h6yaho6Un6yKi73pxSSbsqSJPbI9y8ZuHkgELzlZ5jC55ssZPao0vgDQwOmWj/hXLjA/y+yxnsqI4cCO7SkQMzx6e5ud3V52DAmmuZ35o8zFzgA85JTFUY58Sm6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHD8dPJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51616C32789;
	Tue, 28 May 2024 08:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716883792;
	bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FHD8dPJrkIedrPr2ZLzENUKkss6el7EBxtCxM0dYHf2ioMNvTvsvLY5aL7dicFBr9
	 L6DzlmhLlabqbNKUl4BMHiwaC+DJGxscW9l/4L9LB8VDGW7iWhv/ouN7EwIlAhzmyT
	 DuQoHNbvQjRHmBZrYC7/ewX/C5Z/y2yZQtpP5IKpbp9Lhnr/N2qaRXQXLo3zVmNd79
	 +fRmoXqD+YTj7gjFNXE36rt8kANUPw1gVLm/oZj8Kbi82tVKrFUd7ZUmKBPJnvUsC0
	 A0kcTXe+wpKAEXzf6s72ZFRSyi7NI4dr7cu4dUinA9iu3z0gVnstaGt3VRDANCbKGl
	 JWZkxdXZQcuxw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 28 May 2024 10:09:16 +0200
Subject: [PATCH net-next v2 1/3] doc: mptcp: add missing
 'available_schedulers' entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-upstream-net-20240520-mptcp-doc-v2-1-47f2d5bc2ef3@kernel.org>
References: <20240528-upstream-net-20240520-mptcp-doc-v2-0-47f2d5bc2ef3@kernel.org>
In-Reply-To: <20240528-upstream-net-20240520-mptcp-doc-v2-0-47f2d5bc2ef3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Gregory Detal <gregory.detal@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ypvHqt2ffZwH1g8JlbofDCv9yboiuwJHzR7LWZNKd+E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVZFJaOG04fvPLvTYzxtN8Ki19Diwh+A7MKxRR
 bKX1m43r8aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlWRSQAKCRD2t4JPQmmg
 c8UgD/0eNQevwisbxtTVx9sq4RHlKlcaxBf2kxGg/3YZo2OYJoemJEpXc8H5f64drtEglIEGXtX
 Lpjq2OTZT5SVOKYa6rLrnXI7xwsOUn2gwmzXcKM688xJExJZRdJ1Zex+Unr01KSQ3vTesEd+Mwm
 vOJ33Og+nuYA2N/RDRnFEHFi70DFBBjc1v2U+U9Okl4a42adO+1+LNuKeE1J4t3li7XgozHA57d
 pCPrrU6V8ncSw3eLxrWP133GoIZSK2iHp9xoE7XAvvTzy3whWzguLAs8IYIYfaXIs8Tbu1zZ0vq
 eCjM1Keu8WMR/ypKN1Plgd19Dt8+TMVWM/RL4LFSTndNNnS1uM8iLAYg75s+lzXTyM8aSr4dx75
 OvHKh23JYvlGTYiJJjRXpb+pgIzk5fCXvGw2vYrpeYLRk0JPO5kVygdDHq5mcKiCIYK6109Ry4f
 Ay04VBycLrAgEThQQJC2w7TcEaeokvZYzAFKVs1ppEF1LesFglxsN8hoV1bqEB/H/GQUlI9wd7x
 /5r4tGtkKhzpxTyQjrnmhwWD5lqCRXz5RoVlDpBrwbBjUjTKRqjxR6N86l7SxAGQOAbNidqgYN4
 ZsIBvead2uKHZjd1+urNYBJX072uGDF4xMABWc8hL+jI71Kzp6k8pdrMVOR1fLl7I0xkcl831Jt
 Z9u9eqyqwSosdow==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This sysctl knob has been added recently, but the documentation has not
been updated.

This knob is used to show the available schedulers choices that are
registered, similar to 'net.ipv4.tcp_available_congestion_control'.

Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 69975ce25a02..102a45e7bfa8 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -93,3 +93,7 @@ scheduler - STRING
 	sysctl.
 
 	Default: "default"
+
+available_schedulers - STRING
+	Shows the available schedulers choices that are registered. More packet
+	schedulers may be available, but not loaded.

-- 
2.43.0


