Return-Path: <netdev+bounces-152307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8829F35DB
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A46188562E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3F515278E;
	Mon, 16 Dec 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwM6kwdP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915AB14A4D4;
	Mon, 16 Dec 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366111; cv=none; b=HC+B2Ufpsnhqa9Mnw/YhyoknlDpzbDnuDm1X4g4IUf3HABUYP1+upN8iIz4uFjzjLk1tJYOdSyWBe6CSjnT/GMZM1YOptwCzk3rdN8ejdrEA+V16sYPboNPZ9Nm9pQmRZQq3q7wJECbFu6svOyBfnTDdyMk7kFyKA/xfSMdNmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366111; c=relaxed/simple;
	bh=hUWJKC5xW0TYQmsOZLZ2+oznezYo/SnMcHxYR6J32ZE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=NgSKuQCTwb88Dm3YHYt9cn5TY1rz6LBdcqAD1iiLLg0VejzJMTgfOTr5i+hLTN3UBnJLC2I2eDhAsA2Y8YTBqexs0ihiptftg2WX9VSnfmr1Q3JPmYAcYc9H6W21CARaUs1fKswXh0Ru78nWmsGXlOUwvO/aRFBmUGtuJnx6WDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwM6kwdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B22C4CED0;
	Mon, 16 Dec 2024 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366111;
	bh=hUWJKC5xW0TYQmsOZLZ2+oznezYo/SnMcHxYR6J32ZE=;
	h=Date:From:To:Subject:From;
	b=fwM6kwdPIX8AU7L+HXrj+EPqqLrT0XKyRTrk8AHy5/ORI4v/IynYCl/n8+oGhXVi/
	 kIXy90ZWriFkeq4XTJ9I+XU3DGC5x++4xJIHPoBZj++3NMA7meyyu85tbVSjIlGpF6
	 ncXbUfEY8MquO0CS3IDrj8uFE0vofAyGJCSOXOveSvCskuPuGPHQ5mqw6IbRfgyixT
	 zrRgd/YXR22fAQdNpGaBAa4uL942jgGFo1lxEafoVyAZwq0PlHy32HphbevMBxJJet
	 n9bns0ENAlK4hHPVwdZrXNfoZ94Qk090M0x1SR1wZ8lz0OGmsucJgZjCX6wdU58vNS
	 4dYD/M8qM4IfA==
Date: Mon, 16 Dec 2024 08:21:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: [ANN] netdev call - Dec 17th
Message-ID: <20241216082150.34921299@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

Please speak up if there are any topics that need to be discussed
tomorrow, I don't have any. If nobody speaks up the call will be
canceled.

