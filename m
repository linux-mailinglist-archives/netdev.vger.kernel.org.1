Return-Path: <netdev+bounces-111554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB23931864
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9F32832B3
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B61C1CAB3;
	Mon, 15 Jul 2024 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvUVvoRl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529B1CD0C;
	Mon, 15 Jul 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060416; cv=none; b=bEuLr9zl9HvYH28k2MN2bSL/JtrtDbrGqxi20dYy2mXHLtisCOnO0sEaeQo6ZL9/518M1dlTbIrTd48lPgRIvC+oimqkvJctGd4SlasIe+CX4jbYWfXBLliGklA8ALeiuBQLDmcWcfmrgSFLqkiwwycPA9FQmWOXqNomaLTOWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060416; c=relaxed/simple;
	bh=hc0co17JHVSU9eyq46PYODQW5vQZnNFo2QkDhwMcEwM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Vg41aS7IgeIgEXqmx3FvMR/YxvIyMzkqpx0BkD6BzLPgawhMJ1vwEWCjiUbLlQvkR6tDTIj21l3DTUcfNYA94ASIGNrzQ6eXKmnRk1sK8jc51s8OxBv7S454TiWyDMpxDVfb0HPFvNJ4Dwh2e93I+hzDydk5XkKJqCTA13yZQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvUVvoRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA36C4AF13;
	Mon, 15 Jul 2024 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721060415;
	bh=hc0co17JHVSU9eyq46PYODQW5vQZnNFo2QkDhwMcEwM=;
	h=Date:From:To:Subject:From;
	b=VvUVvoRlzJ3F5w24ID+scTszYowrt7gxMgh/dxNe4fB6wNuRqHso6KDYmVukzQBti
	 3cjr51j255r2tBoJuMc+ouMA6uSKYzSa2uj1FwacIGpAswS8x2ajOKOXfYg2iYMTwx
	 4hhvO3/GmHx2wvzJDR2tcaG/SFpv5jW4sTcztEvaMh7yWHAS9m/UO7glZU/8SEtAQm
	 xB5u0B5h8i5WdiRDDdJWyBFWl33ckuB7l/3XPcDml4a9+PEQSZU98P0ctq61ti/f6w
	 WchTgi/pRVm341YVJtq9uK0FzuuEZK2wfWthW1mDRIOtJiz8wd8u67xtxb1P9DIPFD
	 gFXZILzIEhRYg==
Date: Mon, 15 Jul 2024 09:20:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Jul 16th - canceled
Message-ID: <20240715092014.2f4eaf28@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Due to merge window and ongoing netdev.conf conference let us cancel 
the bi-weekly netdev call which falls on July 16th.

