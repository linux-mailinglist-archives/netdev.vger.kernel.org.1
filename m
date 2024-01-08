Return-Path: <netdev+bounces-62287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C9A826713
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 02:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738C0281828
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 01:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEFF80C;
	Mon,  8 Jan 2024 01:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsnxu1om"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF067E2;
	Mon,  8 Jan 2024 01:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644F4C433C7;
	Mon,  8 Jan 2024 01:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704676942;
	bh=DeV+7HPyCBjCQpbOqifgb05Kfb0knzE1jvw/7It0Ga4=;
	h=Date:From:To:Subject:From;
	b=tsnxu1om5nDtU/2oln5kQ+en8YVM9sPeeftvlAkv5AorROesfQaXBGP2uL02ljuVZ
	 Pn/sHrpiWrCbswGBbglFwVVw5EsppX6+uRGqX9jOLY8BwWC4DgoqwRHNvzbYw0JNOA
	 rFMt6+GFjSZiE+GI0X0Sc99cQmrTmuhW3kytSwn97Qb7Zn3WmjIcOtqy+rp68+Hv7E
	 iYXehu70vpxwiM9Tg1cnarDGUqhYbJV8DNSTQd4/EstKIsKMvdx46NPzzLbfWNf1wZ
	 J65SJZXJRK/hbSsLyrXhN7YQTxGrQFZDYQQU/oyILKW9214nwKEgb1hLAU3wz7uzCY
	 C7c+l80U4bYcA==
Date: Sun, 7 Jan 2024 17:22:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20240107172221.733a7a44@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Please be advised that net-next is now closed for the duration
of the 6.8 merge window. We'll process what's posted for net-next
tomorrow, but please don't post new -next material.

