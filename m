Return-Path: <netdev+bounces-58616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4117381788A
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 18:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253521C23B4C
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 17:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F05D723;
	Mon, 18 Dec 2023 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5R5Vxit"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C81E4BF;
	Mon, 18 Dec 2023 17:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002DDC433C8;
	Mon, 18 Dec 2023 17:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702920030;
	bh=rvJ5CLJgsHd9YYgMPyEd4ePrIvDQgr+6tPH0RQrXuSc=;
	h=Date:From:To:Cc:Subject:From;
	b=i5R5VxitlY4ZzE0lwIEBSWfDP+Yex8qmh6xH2LNNeNfqfajWP2f9DbTkjRRywLxuU
	 osWaKrtk8gBd1JhmcmqEneTRAeNcgYvrL2TIg0OYQRQHaeXsNml7FdGMLTprcz1uMH
	 xemSafNP3NPDdAneqvBigvCbSdGqL2TG09t/p+VLanDcW+z79AowkE7cV4BMRigBYo
	 aZGegyaleHh+0SclOdse5fIbFKuDcOtf7iLfdS9KWgkAm6Bjw/eK1PQKcfMwc72BDb
	 tYMha/JhHg1oXqcjlJIUZP/c9OdQU1CY4+3d5669FLfbuvPgk4uIYnNzttanAxBbVO
	 /YZHryG91xgYg==
Date: Mon, 18 Dec 2023 09:20:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com
Subject: [ANN] no call tomorrow
Message-ID: <20231218092029.74f4da59@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi folks,

many people are on winter break already, so there will be no netdev
call tomorrow.

This weeks reviewers are: Intel

Happy holidays everyone!

