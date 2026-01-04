Return-Path: <netdev+bounces-246767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A40ACF1170
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 16:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2A883022A8E
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 15:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF53618DB35;
	Sun,  4 Jan 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzZ0McrO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44654C92;
	Sun,  4 Jan 2026 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767539000; cv=none; b=MlAlctzI3CGAuM3AFHZYt7mx1Owk3BwbT6mg+9W0Hc/qkicBPOo24lyHlLn2tTFOzRQiabzg16SMS7SLbK/nuiLW8zjlZDhio2jB+BgLtdVK06NQIXPDjPbZzSaASJRblMD0qkdSfvpQPPNKqYEV/n+wwBEnRom+JU19D0TPExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767539000; c=relaxed/simple;
	bh=T3VMIRsn70Xp3RgTb4hVWSwaRxNXOzRBc1Vlhm2k374=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=bOdiyrWzwScEPFGjrUXHOy7jtWA5Og/FEinQ+eIhIUsD0J9241mio/wJ0GYOZVcYgpQaQSQEDRifye6plptpDAmrape++2J27Cp/WGWrQalfWBsKKP/90cT8yOTTeSKRbw0RVJMo0SBa7SEc7QfLbZwosHLIX+YbNaGt3vBvd0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzZ0McrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28944C4CEF7;
	Sun,  4 Jan 2026 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767539000;
	bh=T3VMIRsn70Xp3RgTb4hVWSwaRxNXOzRBc1Vlhm2k374=;
	h=Date:From:To:Subject:From;
	b=GzZ0McrORu2Mi+MQNscFWvtB/UVKjdCFZcAn9vLA8+lXSwgU3oYiAwkoAt4UpvkOS
	 UY4Gc2vrrtAPQYVZrNcTKTS/pmes6N8qkvEZ+vd0OMfECnBW3SfIVgAveGvnp4Rja9
	 nQXHS1Fz9srcaNywDJW4PLpg1RRb53LsUnkk3PuIvafIJhxD24EkiiKSEu5vW5iyLp
	 vFPz75eXzn+dPwT4lx4NWh2aVjSOtvlrOE64d7am58eCBlQ2gTYHCRXh1uzPwc+KVc
	 7n7tFYqY1ya7G3az4g+IMNo7lv80haqeDiuTq68/kuTl/s3dNOHnro61O4PzWwb1ho
	 71a1dlE6NehUA==
Date: Sun, 4 Jan 2026 07:03:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20260104070316.6ea2b9d3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

net-next is now open.

Hope everyone had a good break and a chance to disconnect.

Happy New Year!

