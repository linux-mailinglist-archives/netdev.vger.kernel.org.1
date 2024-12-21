Return-Path: <netdev+bounces-153865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2047F9F9DF0
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 03:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCCA27A3138
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 02:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375870825;
	Sat, 21 Dec 2024 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4PQL3JZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C1DA59;
	Sat, 21 Dec 2024 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734748132; cv=none; b=VLtY2UB6OpZ1illlMNw2LPB1W9+QNXaI+UQABppF284Jdv3Rd8A4Ves9mhPLXHqYlZLW+50eqbxoDGoPitT38JEvdMPX4H4z5Uo7dc/6KLxzC3CK/h8NKNYMQDoChkj7wCpcAsBTCFXAQcyYIPnLM/EwJH0g9DHH0I8sT+NAn6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734748132; c=relaxed/simple;
	bh=8C7FLsu6XrhaG5Np6bSF6+dU5OvsiqtoO63sngCHbfc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=AjTxiw9hvKIto3fFi9nBECTlb329N1u+hHrQxgSYYdoi+t6YEYiuIyNSL5eMhTRt4RVyVmvMjh/ElO2diFQ2TeChOju7X5cLqVo7B/BSaEZ+7a5jpOUZD5mfY0yUFgKqbiHXcN/HWAuqqkVlcBqqZ2LzcNdp48MzyFIdis8VU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4PQL3JZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F148CC4CECD;
	Sat, 21 Dec 2024 02:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734748132;
	bh=8C7FLsu6XrhaG5Np6bSF6+dU5OvsiqtoO63sngCHbfc=;
	h=Date:From:To:Subject:From;
	b=W4PQL3JZ+u+henxqvjv40TxOVgCL6MtigMeqOPIzEy04tPxxWG4mGdZ8Z37mXYfVI
	 m14ioOftCvp13u1RUvKwOxMV1W71IAHJ7TKU982lwvDOR3rNCnWGDLZJY7aLcaIB/8
	 YLCkU132bP+OlKSjbG7VVNlVWs9+NZTrydY5FHdRfpT/mIXlPqux1Lb40oyS5BNR0h
	 bNRlmo6WevRRLufzWoj9b3IpnVLyx4UX0bpMiQT0Rb1yTrO7xQMs0VidgBjUJvuRnO
	 6ho9ppc01INqFD9UjQbfQW4qCZWhv7y6rKDFxAqZCw5UJUOIoouyANxHU6F3l/MjS1
	 3W/P80puPYi7A==
Date: Fri, 20 Dec 2024 18:28:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20241220182851.7acb6416@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

As previously announced:
https://lore.kernel.org/all/20241211164022.6a075d3a@kernel.org/
we are closing net-next for the holidays. 

We will go over what's already posted over the weekend.

net-next will reopen on January 2nd.

Happy Holidays!

