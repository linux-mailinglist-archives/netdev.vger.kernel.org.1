Return-Path: <netdev+bounces-79183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C8C878283
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B191C2168D
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 14:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038875B697;
	Mon, 11 Mar 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4Xl5fW4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E445B691;
	Mon, 11 Mar 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168678; cv=none; b=cFsIT5+nUo6nbZpxIDbqGqKExU1hQGsaLdIieQvCZNa45FHzgDc4z4fzHkOClG67RUIy13o+Fdd2NVVWZICQFCVhpHoEO6tdW2nuw1MUQqq3zcEmsEfsjhhN9+dxs3ND3z4ZokZlDv7LrS421cnjbXScBDuaPcle6OXn9wH8GX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168678; c=relaxed/simple;
	bh=H6XqpghiAiKVb08HOVLpeYOx97PwCKItgaLe6ym55Ok=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=CS2wD3QPS5krZLWtThmZx97s/+9VkVWsbUm/40aPsjTjx9G4d78PEO74oKWECco0ZWmDS/qjMuv/vDvQM0pUS1Rrf98+2F4X9MSZ47t2LOewkUfH+eEiqoerMNRbenul6uo2SoVyQjrzHqmd6aqtHxh61B9BykVYVOOryiDvh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4Xl5fW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A5FC433C7;
	Mon, 11 Mar 2024 14:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710168678;
	bh=H6XqpghiAiKVb08HOVLpeYOx97PwCKItgaLe6ym55Ok=;
	h=Date:From:To:Subject:From;
	b=o4Xl5fW404lhQPMORlXDO0TiOheWT/aqK9MPFeM1IoU02PNaXUsHGDDxVQBRTV9Zv
	 k3A3Qam500MgTvXVMh3q8sHFTVEfev9aaSSVajPOAKCguoT+/ukUZKUNeIjs1KJaM7
	 mzT/GH6ELuir1KT+4IP/un009GLgfFsGzu42Cxr0sMZ66Uwb2WawO35xloi5ijQErY
	 5YUVC3uSFcF75vazeXwMU6Hk+fYz6STgjftfIxZ0YCo9oBlqbbSWOlJ0ouBFBDocbz
	 P6xz7D3BuTG0F45T80WEpWK3FF93eZ5HpoNOFTbuFPG2kIB924P5H1XGRw7xZ7jmmh
	 HgpOXRr7cwpjQ==
Date: Mon, 11 Mar 2024 07:51:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20240311075117.2857ae10@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus tagged v6.8 and, as is tradition, for the duration of the 6.9
merge window net-next is closed for new submissions, until 6.9-rc1 
is tagged (on March 24th).

