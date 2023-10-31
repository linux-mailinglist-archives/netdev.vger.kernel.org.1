Return-Path: <netdev+bounces-45351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8EB7DC36A
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 01:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBD21C20A79
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 00:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7451C30;
	Tue, 31 Oct 2023 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg+xgsXf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF71C2E
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 00:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B3AC433C9
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 00:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698710777;
	bh=jbCiZRKohCfuaYBlcRuHSlnVN5LUrkotEgy3BTI6RaY=;
	h=Date:From:To:Subject:From;
	b=sg+xgsXfktNle8ES48VGqIevWV7C168X9dY1GKCTzvSSWEYtbzecpCHVNEJuLqeeg
	 eMe1W2ghQo5TISy/pHBYKGM9n4IK2UYRs9eN/7cv3s0uJrOQ8VHJgBRtN6FIgOYYUS
	 fBQqEEVn4aFvAeui7cJlQiMjm7wsabckjJRL3uLkT2km2Rp4eyn5ZJJuaRqDFSsXB/
	 8G90AzH20KoyJ2BztKETg7KegIkkkbesNfGB54qcTqPeBN4BEEVRylXZVtJ8+p6fyL
	 N9bB15ts5bgTjgRdi7+NFhy9xMYS5V9aix0qQH/dnub0NzqWb6oDijcnSJAgVVqhhj
	 8ZlGRy8HQprwg==
Date: Mon, 30 Oct 2023 17:06:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20231030170616.6e09a12a@kernel.org>
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
of the 6.7 merge window.

