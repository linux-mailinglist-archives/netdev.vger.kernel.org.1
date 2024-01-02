Return-Path: <netdev+bounces-61050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 327658224F1
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A4F1F22421
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3589171D9;
	Tue,  2 Jan 2024 22:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFSg+GON"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ED7171D6;
	Tue,  2 Jan 2024 22:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA965C433C7;
	Tue,  2 Jan 2024 22:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704235690;
	bh=6n6/P/dTeO7pAc3BjfzegnWFJTWIahU40Gjt7KY0OQ4=;
	h=Date:From:To:Subject:From;
	b=oFSg+GONDHaq6ZMKUkjVnXo/Z3XSXY4NB5ZkPl5N72TIdqilKL4rfvkefhBe/5hl4
	 0Tl4IgoU2/etRsMR0mDjIyh+astPRW6C8l4MBFxUVe4WWbdmWMPPJ1SfafoYnuayoH
	 2jUDJKjtFeQPATBDBFMthnCvYXRkZXw2gtYzMQsuUTebF5e9XrDRm+CawSIeWFSkIE
	 72wVHPQFaQT9ivpuJ5dKA2wz9XmC6J1jVFTS/95MwpxgtDx56fKsBY8QDKf8EoYXs4
	 5W3f0ha1YXFfhJwKpqxaCkZx0WRVwUauFvVp5ZnKuORdOLscC4re/yTX4RHyzo2XyO
	 6ZuI3lL95c+cw==
Date: Tue, 2 Jan 2024 14:48:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] Winter break is over, net-next is open
Message-ID: <20240102144809.6b44858c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Hopefully you had a chance to relax a bit over the last two weeks :)
We are now back up and running, net-next is open. A few key reviewers
are still AFK until the end of the week, but the less patient
submitters are already sending stuff, so let's make it official :)

net-next is OPEN.

Happy New Year!

