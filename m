Return-Path: <netdev+bounces-154775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB59FFC4A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193CE1880982
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6144417335C;
	Thu,  2 Jan 2025 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEmI5vd6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0B541C69;
	Thu,  2 Jan 2025 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836515; cv=none; b=ft0TLe3I2usDUDLUcHCQybFIfCjE1tj690Ae6FPUfJxH0JXwmKIz2yz4+jBnTmODDzEIKzgq22R9NwfNkFqdhMsD9kK/aEWisIKSCesc9P88gEHRVXZaLXhjFKL7Vg8EXb3YP4/+OZn5OkCTeqTSlN9l9kFs0j5gX9YnKQHGDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836515; c=relaxed/simple;
	bh=9ZNj74xTpAZkn4qiLCcWjoy5qj8jUgcU0QDBTZuIoPw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=brz1DOJlDF4pC+Rh+E/MQEN7lRCDSqkoyGsCS3MwH5V6N8nZLI/Bd6/spvw2GwDmHmYM5c4W+A0VVB9axVkKIR4x7kAmyqrxmjnNYVbq0nb1vi79KFJkhO4n9DtPolDlW6Ys+16m2aPPJSniW/qG8W67DhJWpUs4qnI3R37rdUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEmI5vd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77627C4CED0;
	Thu,  2 Jan 2025 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735836513;
	bh=9ZNj74xTpAZkn4qiLCcWjoy5qj8jUgcU0QDBTZuIoPw=;
	h=Date:From:To:Subject:From;
	b=MEmI5vd6Cy6cUFi51Bu3Y3dR/vnJ0ckSlk81rSiMK2h0/D0nKeVCaR9ueD0XyNBYG
	 HO5gyUX3nAVjgL0liEl5VeJMvAZDW4jZc4d9TiZ57TMwS4SrG+3XhrgMrtb/R2KV+t
	 W6D5N9zfa4oQtPSjd58AP5wcNxMjOgwR48aj2fTRmId1yRkk45u0mgDElS4PJYLVyl
	 5DkAm2CEtjVq/xj1bM3Z6hz+46D9qoQoXdS+SGmgPbI3p91AoPnig3vXx21TnPUN5L
	 POkxOB0hBFOyCch2alHALsz81LHQD6L0hHPz9Vrm4DeSaqTQAnXDk6eYdx39zM/qGN
	 9AqCXPUNijL4Q==
Date: Thu, 2 Jan 2025 08:48:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is OPEN
Message-ID: <20250102084832.05ccca2c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Happy New Year everyone!

net-next is open, again, that said please expect review delays 
as some maintainers and reviewers will not return until Monday.

