Return-Path: <netdev+bounces-181034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A79A83683
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4265E7A1A4B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C01F149DFF;
	Thu, 10 Apr 2025 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy9WOP0a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27816136658
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744252239; cv=none; b=s/08XwoacPb2zTmdCsg2qLqb/2H2IRUJ3TAwGSvtL3fv8p82MCX1xT6wOs/byBw53qOczg+3UvO7MloGHkUU+Z+Xqrw4bfI7UTXaZiqHp68HRLmGUus63fzOfFuxh7ZHEYNKWTzIyB20BWBmvCin90zbYhauXnBQCV9Y8lwWy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744252239; c=relaxed/simple;
	bh=MCe5HPUJVUbFBEVR4yFU968rCk7KX/l36W3m4pRD7qg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DmL6szCaOdSrMYaSntu8fQQOMwPX7BE1fmg/jwPVoo0Wyvkm1uq58FAqAabwgoxrWgugE0/5l7MUBqmzN3us57dTLWq7v7Xds3rQ/t2c60R71CcRTp9lHJi3TLPCQ9K9ddUcMOcpGJLh0/GZThhyByLYEHGFmm1G8f+0ZG+V0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy9WOP0a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBF6C4CEE2;
	Thu, 10 Apr 2025 02:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744252238;
	bh=MCe5HPUJVUbFBEVR4yFU968rCk7KX/l36W3m4pRD7qg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cy9WOP0aJRQUJ/+b/o3wpaMXdQU9YlZdNKAFjwRwhiMJ/zwZ1GZShcKREQt7zjZLM
	 1XylVUSBUTZP7Ku41mZild+ooqRQnb56EKS03/pRdqdNPORBT8op89nQi9ZwZO7HUx
	 W9NmvCVU0Enj62Lb8eDP6GsGaZj9Se8ZyLi1HmydQJiOU+ith7C5M0ISsY+1jShWvr
	 /0ZHpfOe0la+/fLHaCUPzPs5cbvGPvzAA9/0SApGV0gzjuubDuYfM0559+hqTzcRcb
	 BwAwPz/7plbuQ8mUeb59Lqw4T3NuJTXR9/G4in8cDJNTU76zdWaA3mO1EmB3OxfmAh
	 QYxb9psy5K9jA==
Date: Wed, 9 Apr 2025 19:30:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@trustnetic.com
Subject: Re: [PATCH net-next v10 0/6] add sriov support for wangxun NICs
Message-ID: <20250409193037.78aeb8ae@kernel.org>
In-Reply-To: <341CBF68787F2620+20250408091556.9640-1-mengyuanlou@net-swift.com>
References: <341CBF68787F2620+20250408091556.9640-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Apr 2025 17:15:50 +0800 Mengyuan Lou wrote:
> add sriov support for wangxun NICs

In the future please make sure the patches are sent in reply to 
the cover letter. git send-email should use --thread IIRC.

