Return-Path: <netdev+bounces-156037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C91A04B7B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158863A05ED
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8EC1F3D47;
	Tue,  7 Jan 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnnr81f3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35391E32CF
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284726; cv=none; b=GwVvlsmjY+JRsF7DZomaowIWhsM0RreCgl87ZstAFy8nfG9xvQj9lY63THp+A4SlPpi+pnistuaPdDqu0+WdciTJLTEAla1sYkq1ezhTzQ5r/eKzRNLD+nRiiOoF89oVaY//pd8qdr1IpD2gYhy5YKV44AGVPbKhYSCEjtXn2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284726; c=relaxed/simple;
	bh=VwRFrywHG0aqfAtoCDn/CwUgYqAuIv9Nk+rLQuPpEV4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qlCVn064CILviCQYpS/FEWyrK6FyMYsklPmmSUAqJbhROT4gCkKZ0GRAIB5JuFzPg3M9YnNl02hguG9AEi9cmT3+55s1VWE6qQJGQA1gEKipmNmRQ1j5Udyc2woZNvMgAucxDSwoHZJNdqKJmzxpQlyYkLs91nYEEaRuAzP/fwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnnr81f3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F40C4CED6;
	Tue,  7 Jan 2025 21:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736284726;
	bh=VwRFrywHG0aqfAtoCDn/CwUgYqAuIv9Nk+rLQuPpEV4=;
	h=Date:From:To:Cc:Subject:From;
	b=hnnr81f3px9ja0H0rT6rRqNMHWYhGv9kHhZBV4dn7usFKVz8CPTEnzn0EVy77obC2
	 QkP2IEjW5OkOV0X/5dzdNEjbN7NxiXbRyODg4X8jj1Xj0j0fj/hQiwSNRJb/kXf/OR
	 UU9vKuRZeZ2jnVjNBl7hjvPe5dxcGUVjasGQ7LpuTWTgaw8mONghcqwUxtASADrHm+
	 qGH788JIvqEthOVaY/U1WBDd5E6YQYYXDirxosJz/4AjbTHnS+Je1tBrU9IGgaBGLY
	 hwgdF6ZsW1dLtJFq1PdVk0DK1/iamTESM7Vqxd2xzcyaSucjPmQWDv0WwJMXKqonAJ
	 CSyPeGTnV4IxA==
Date: Tue, 7 Jan 2025 13:18:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [TEST] mptcp-connect
Message-ID: <20250107131845.5e5de3c5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Matthieu!

Unfortunately mptcp_connect.sh has started flaking again :(
Looks like it started around Dec 30th, so one of the recent PRs

