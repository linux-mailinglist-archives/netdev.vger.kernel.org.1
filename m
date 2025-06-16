Return-Path: <netdev+bounces-198049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C21CADB0C0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB841886925
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAB027A139;
	Mon, 16 Jun 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfKvOAio"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563F02E4264
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078719; cv=none; b=RPkuXwzoVZXobZpOColJCv2ys18zmsRIVXgYFLImXwDbMVLzFVwyxuktdCoyOMIQzaCuZw5+8fCyJAmeQkJt7RVWpVTNUEv6jjYs+fTRbsRWRY5DjH5FxOd6tIcaLcFU2/WvHw7di+WuyHY45uv/uLLl2BBPOVF+BHlXCTmED6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078719; c=relaxed/simple;
	bh=ub6lGXv+rYDJNWvqvlx/EUOGDIEZSGIbf6O4h0mkcVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u5vrUrXUzhVjLNJ7naiqOS/5Jjj0vUOGygDhAqlLV+W1ZIWGirefQsq5MbirE02GSEfbsGS3cM/+nAjTRvbURGFDF2RynULncoz2EuYzODL2w+sbPoH1Ut7jx9OeWaUfAYMVUmWILEXXDDb0TpdJcG8ObN2wozXgFNX21LtSS+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfKvOAio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2164AC4CEED;
	Mon, 16 Jun 2025 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750078718;
	bh=ub6lGXv+rYDJNWvqvlx/EUOGDIEZSGIbf6O4h0mkcVw=;
	h=From:Date:Subject:To:Cc:From;
	b=FfKvOAio3RNlCQuKWDLUbFRItp+P6slfsrU4LzRYPURDx4muqWCz2LmREpdPyyu94
	 X51A7WWgdVFsO07zi+bEn0R5RM1jAu2SAq0+enkZN+1MLf9D7SK9AZQZjMGDrwUXUW
	 8/mulC7S/n/68MTRQwVKtx+sBilPUGgefQKapxt+0RCa2LzbsLlwCV2YzPwcSo4Qpv
	 csNpYWcbMWEJ7dEINkBSBUn9PnpQ1Ye/XkQvzuw94Qy5fEBdqw6kRuKCPlxE6YKAE4
	 br+X/0f4wjNmLYJHd6Zasb/YL1NC45CaeFzR1s5p3TBIaogsvBGAzh7IckoBLEX1lN
	 o578amFY2uJ4A==
From: Simon Horman <horms@kernel.org>
Date: Mon, 16 Jun 2025 13:58:35 +0100
Subject: [PATCH net-next] dpll: remove documentation of rclk_dev_name
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-dpll-member-v1-1-8c9e6b8e1fd4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPoUUGgC/x3MOwqAMBBF0a3I1A6YgAHdiljk89QBjZKICOLeD
 ZanuPehjCTI1FcPJVySZY8Fqq7ILzbOYAnFpBvdNkYZDse68obNIbH1rVLWWWjXUSmOhEnu/zZ
 QxMkR90nj+34sjdoBZwAAAA==
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.0

Remove documentation of rclk_dev_name member of dpll_device which
doesn't exist.

Flagged by ./scripts/kernel-doc -none

Introduced by commit 9431063ad323 ("dpll: core: Add DPLL framework base
functions")

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/dpll/dpll_core.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 2b6d8ef1cdf3..9b11e637397b 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -45,7 +45,6 @@ struct dpll_device {
  * @dpll_refs:		hold referencees to dplls pin was registered with
  * @parent_refs:	hold references to parent pins pin was registered with
  * @prop:		pin properties copied from the registerer
- * @rclk_dev_name:	holds name of device when pin can recover clock from it
  * @refcount:		refcount
  * @rcu:		rcu_head for kfree_rcu()
  **/


