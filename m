Return-Path: <netdev+bounces-73025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D189785AA2C
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB12B20BAD
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2957A4594C;
	Mon, 19 Feb 2024 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvQX4rs9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605126288
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708364753; cv=none; b=n3Ui+bprN1EG1RpYb8d84nb0fdfOkEAsYrIfGwV8IuhvWoUTONaWF0eiB/e4Y4lrCa5/R/Ycz+j8ufgUV6UM5BQFkQS1Cp55mqsN6kwVOyvtEN/3FHhmmZoWWkviQBJNpwqSVJsAIdzxU6Y/aUoYtyh3z4L+yEQ7wul4n1ZLH2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708364753; c=relaxed/simple;
	bh=KTCITt9O5myspdGo426iJ4+nJ2+nOP+V7ZYQNEWNWwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j102vWe2BPgQkh+ecvnZJaANzi+92cRHajlpp33FVROQay3OSmSFavt18k9dDeLe8a1d2QBocTMJJP0MdCevysxGtEu/i723DnRYYbyz7c1ZY5NWYdnHsQnId6yvFQLuSvt6w/wnWscLYHH7Wd1QgJFTnFgJGTTih3TwAPJR+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvQX4rs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151EDC433F1;
	Mon, 19 Feb 2024 17:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708364752;
	bh=KTCITt9O5myspdGo426iJ4+nJ2+nOP+V7ZYQNEWNWwg=;
	h=From:Date:Subject:To:Cc:From;
	b=mvQX4rs9/cFnJcezVOatN9pdruGOLwbRc9CD1phyhUEW+x0KrjWTtHemF1QLBcYzF
	 4yNtknlxO+PJtQXKgAYRlL3mHnyebVqSQ9TbkR+kbu+v+iDbXMMs9cRUD8Yv7f1h2t
	 xF+mCaufpJ24zW4GhT0o7hIWrgaRQ68SDyT5ypXJRBVZxuB2TyB5plGTuouVMzTHav
	 AeaNH5ADa6yDZhraiSg85wQsqWlZLKdTfbEgtOjAW1/w7BLb5v9+ZkeUT0lcuINjmo
	 Y8DKpSmx5XPOSIvKO35M7Q4Yuhy1nCU/a/1mDwZ4vf+RGIkB7PnguKQhIHLSP29KRB
	 Zo2kzRoF6e5og==
From: Simon Horman <horms@kernel.org>
Date: Mon, 19 Feb 2024 17:45:48 +0000
Subject: [PATCH net-next] net: wan: framer: remove children from struct
 framer_ops kdoc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-framer-children-v1-1-169c1deddc70@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMuT02UC/x3MQQqDQAxG4atI1g3MpFaoVyldTMffGrCxZKQI4
 t07uPwW7+1U4IpCfbOT46dFF6uIl4bylOwN1qGaJEgbJN559PSBc550HhzGt5DD6yqQmDqq1dc
 x6nYeH2RY2bCt9DyOP9Z3b1prAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Herve Codina <herve.codina@bootlin.com>, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Remove documentation of non-existent children field
from the Kernel doc for struct framer_ops.

Introduced by 82c944d05b1a ("net: wan: Add framer framework support")

Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/linux/framer/framer-provider.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/framer/framer-provider.h b/include/linux/framer/framer-provider.h
index 782cd5fc83d5..6c2c4ddc77bf 100644
--- a/include/linux/framer/framer-provider.h
+++ b/include/linux/framer/framer-provider.h
@@ -83,7 +83,6 @@ struct framer_ops {
 /**
  * struct framer_provider - represents the framer provider
  * @dev: framer provider device
- * @children: can be used to override the default (dev->of_node) child node
  * @owner: the module owner having of_xlate
  * @list: to maintain a linked list of framer providers
  * @of_xlate: function pointer to obtain framer instance from framer pointer


