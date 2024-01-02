Return-Path: <netdev+bounces-60929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2DE821E5A
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 16:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5E71F22F21
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EA612E6B;
	Tue,  2 Jan 2024 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsC/wvwW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06C414AB7;
	Tue,  2 Jan 2024 15:09:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26578C433C8;
	Tue,  2 Jan 2024 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704208165;
	bh=ebnRi5ZHNgpPEnSdxSBO0OVxsqUCg8zKbOyflZYCF5c=;
	h=Date:From:To:Cc:Subject:From;
	b=qsC/wvwWq8qvxooNnnMD8mDcndqmTIZVJBgVBaqDI6p9SXwa9fKoxd8u0wiwOue0E
	 6gme7M4cqyhWzVfd3qx18C8uHD9KwSJKdOuW7OqDz9/VRjNsoPbqHQuwxF7SiDb9Y2
	 Roqwio9scxz42rIry0u2Kc7RSjXTMpV86jhlAghM8A2IZ9jgKxX88ps8ic/XkPZ6rJ
	 U8XPOJQPUf8UIxHjOj7lMmJWbm0X3PYXIyob1yfA7lYFxKfWDWGCxWYwNEIEPho6c1
	 LllJN9b36hX2DUsk5hGsGRpt1ZQ+HnmXloqrWWl7Bpgu2/pqayUytvV8f2RXuk7NSd
	 YKbiH3gMOaNww==
Date: Tue, 2 Jan 2024 07:09:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>
Subject: [ANN] no call today ?
Message-ID: <20240102070924.372a7cf9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

FWIW there's no agenda for today's netdev call. If anyone has
topics to discuss - please reply, otherwise the call will be
canceled.

This weeks reviewer: nVidia

