Return-Path: <netdev+bounces-225009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B10CB8D0C8
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 22:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE951B25741
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025B22D3ED0;
	Sat, 20 Sep 2025 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoOkVpwX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6F27B32D;
	Sat, 20 Sep 2025 20:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758400722; cv=none; b=Q8Coro24NT9IjkvN3TjCAf2ztz99EqUzictCP9h9ggbNSX3QwqXvffD3QGPZmbw7NawBIHTVXQ11pMMCpyOMNCnyS5Jg09mingWfp4Fn22A1YK3GJ01njYYKH0y0Fyo58X2ywLWoZQyK9Q4Ml7HXHQ+wPhpHIijLL7lbmRzpxiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758400722; c=relaxed/simple;
	bh=x2O/pexceUbPBKtX0Nabd8CFwI++Z2rk3qDvdBeT+pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIbvFM+vV8/l012fVDpRfmTzygKOo0Cb6uB8jCgzhKq3nbdhBzToSc92DeXs+B0wqcDISyNU401lVegEalkqiiEr2TLh2oGv6Olat5RgSfM3YJYjWKg6EofKohl/l7rRBRmi9F2NaisKJiTFBCZunWYiN8qfTL+xoGVcs4bCro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoOkVpwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C6CC4CEEB;
	Sat, 20 Sep 2025 20:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758400722;
	bh=x2O/pexceUbPBKtX0Nabd8CFwI++Z2rk3qDvdBeT+pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YoOkVpwXnHiOxRi4vWEQ1v8shTBBTv7pnuQqk0UrI2SpjkFsbF4itoZ1zuQ1Q6EVe
	 xVOpyfkiJsc8aMUthqwJ4CzVi2Y6Axm6m5qQ2q+15oEiPvYex2uUYn11KZzWO+G2W8
	 5YRn94Pj6qshu/fz4wpeioa5OnrcS99bEVYOBSMhz6qAzVovsa31BfyMv29t2G0FbO
	 fYMd44b/CdaHmvMT/oXCPCGkIS1TiW/+NgE3mZcch9qn7LdCQQDxYsTkt6PMnoMA5p
	 M78jSVxANa8K7u5rcyTh96gSQRbDxVi443K7IoFizof3fRnnyjcf1Xl1TuYU+onUkT
	 RpTjkosN2tEYw==
Date: Sat, 20 Sep 2025 13:38:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2025-09-20
Message-ID: <20250920133841.38a98746@kernel.org>
In-Reply-To: <20250920150453.2605653-1-luiz.dentz@gmail.com>
References: <20250920150453.2605653-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Sep 2025 11:04:53 -0400 Luiz Augusto von Dentz wrote:
>       Bluetooth: MGMT: Fix possible UAFs

Are you amenable to rewriting this one? The conditional locking really
doesn't look great. It's just a few more lines for the caller to take 
the lock, below completely untested but to illustrate..

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1e7886ccee40..23cb19b9915d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1358,8 +1358,10 @@ static int set_powered_sync(struct hci_dev *hdev, void *data)
 	struct mgmt_pending_cmd *cmd = data;
 	struct mgmt_mode cp;
 
+	mutex_lock(&hdev->mgmt_pending_lock);
+
 	/* Make sure cmd still outstanding. */
-	if (!mgmt_pending_valid(hdev, cmd, false))
+	if (!__mgmt_pending_listed(hdev, cmd))
 		return -ECANCELED;
 
 	memcpy(&cp, cmd->param, sizeof(cp));
diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
index 258c22d38809..11b1d1667d08 100644
--- a/net/bluetooth/mgmt_util.c
+++ b/net/bluetooth/mgmt_util.c
@@ -320,28 +320,38 @@ void mgmt_pending_remove(struct mgmt_pending_cmd *cmd)
 	mgmt_pending_free(cmd);
 }
 
-bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd,
-			bool remove_unlock)
+bool __mgmt_pending_listed(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd)
 {
 	struct mgmt_pending_cmd *tmp;
 
+	lockdep_assert_held(&hdev->mgmt_pending_lock);
 	if (!cmd)
 		return false;
 
-	mutex_lock(&hdev->mgmt_pending_lock);
-
 	list_for_each_entry(tmp, &hdev->mgmt_pending, list) {
-		if (cmd == tmp) {
-			if (remove_unlock) {
-				list_del(&cmd->list);
-				mutex_unlock(&hdev->mgmt_pending_lock);
-			}
+		if (cmd == tmp)
 			return true;
-		}
 	}
+	return false;
+}
+
+bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd *cmd)
+{
+	struct mgmt_pending_cmd *tmp;
+	bool listed;
+
+	if (!cmd)
+		return false;
+
+	mutex_lock(&hdev->mgmt_pending_lock);
+
+	listed = __mgmt_pending_listed(hdev, cmd);
+	if (listed)
+		list_del(&cmd->list);
 
 	mutex_unlock(&hdev->mgmt_pending_lock);
-	return false;
+
+	return listed;
 }
 
 void mgmt_mesh_foreach(struct hci_dev *hdev,

