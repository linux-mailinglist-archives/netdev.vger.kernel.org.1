Return-Path: <netdev+bounces-162139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE0DA25DBE
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501FB16D448
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE743209F4F;
	Mon,  3 Feb 2025 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMg4Xm+z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A10209F26;
	Mon,  3 Feb 2025 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594464; cv=none; b=i29AHhG3gZlQlE0VuBtIu4u0I2qVGO7r9xuQy6cZJaUwcvMiA2o5YBbOA57XPb0Q7JL6wEvFfL34wGbdSW6buPZGwrzkMLDeymWIyzaw4QMebJPg4Lsoo2dHZWqkalgt48HCX74RtC9Kgp0HQpHQBWVB1k9dIbUX8ibW9mq/Ti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594464; c=relaxed/simple;
	bh=EusyX0VMt0J4uk6uIg0A/SJi9AyYQDUrosE0EDhUqrA=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=mkkxF934yEVGWEd0/K/JVULMssdo61Wczki5jJuRvXxf8ogGL0DGlqKLnhL8jjAAQMvXXvPGFTs/NqpBuPB8hZOdKaXvMND9ga5Wqnj4tJXjm9Lb39iXcV5ogLsKzK0CmqkbJaIGDeAwsPz+qkd3pJM2MVOyI6Cf2ZEp9w76++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMg4Xm+z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40A3C4CEE0;
	Mon,  3 Feb 2025 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738594464;
	bh=EusyX0VMt0J4uk6uIg0A/SJi9AyYQDUrosE0EDhUqrA=;
	h=Date:From:To:Subject:From;
	b=PMg4Xm+z3mGY8nj1j9+kcidvM2VIbgxcLeuK+Ks30zT0CcvQtiW1Dxsg4T8mW/UhR
	 +uzIIw+guDwKNr/Pdaycf0T0eiDZ0zGX6wcgmxf2lux059tnBEDpQirLQ7g2FBe0Ua
	 LBGcsfH8OWwxX3jNoHN9Cv5F43247HWcKes2RJKEmcpixYmIN8waAn5v+alABq8rZt
	 TvreFpQr0QRoyKEjmSyNbgPRVvBTwWiw2zmYlw1Az+NbczSpApGcLA68dEBlciFAfM
	 7ffXhFH43d7ean6ifcXtV3s++juc4FEeWvuMOWjnGX49UsEcPhjcVKaD4mi8DYchlo
	 15h5j2oq2lrRQ==
Date: Mon, 3 Feb 2025 06:54:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20250203065423.03f4cec4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

net-next is open, and ready for your patches :)

