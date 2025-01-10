Return-Path: <netdev+bounces-157274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D850A09D92
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A38216ACB3
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE9B212B0D;
	Fri, 10 Jan 2025 22:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSJRi90N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F624B254
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736546772; cv=none; b=RhV3sHGgFQTvZe+3Bh1DWHLffa0IZ8TyyjOvA3YOiuodZAzQxviDxaXc5qNzHbyDmjjh8ALX9fCCw+d/2sygs6F5h1ZLDq7WcyBIPW2nnyht4LtxlBAddYlDVW2uexIlFOD0pBVRh/1RraQ2ohXAcPZDbykS3FDF6BZtYyUafxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736546772; c=relaxed/simple;
	bh=OmmfDN4nS0brLl3DjzJQ3KPCQeXessK9ubs8YbfyKu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gI7mzUBaKRvVD+ZNVemMvY4tS3VL3rZnScjwt5Qq3vVIT7nobfX0yCfGPhtMgsrbjndMyAfG2hA40QnQjCbfFrZq4kPljIXtxxQyGNc4i3yYDsIOHHQE2Tk8L0TAF/y4AUt/5T0FMHbuz8RFnX3LZuGFBvbVizONAo6HTnZ37qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSJRi90N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5ABC4CED6;
	Fri, 10 Jan 2025 22:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736546771;
	bh=OmmfDN4nS0brLl3DjzJQ3KPCQeXessK9ubs8YbfyKu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XSJRi90NGDPE226wxA4Vc3kkjTzXKgbfUDtzMeEIFQp2t2SbJcOjdTViUF1CIiCao
	 XzwBKV7TR5xZG2+iy/0tMBM7Rqkh5NLUQ9loWc4PwR09ZbI9eIGYBHI0YE2GLeQEO7
	 p4E+302/U5xoIuUtWIKaWIJDqFvjfU8S5cQiH63gQi5dDiwZORMpXUTYLh//doxoph
	 w+cBrZxDQuNIEC7ZcGJL6sUnAY+BGwKBsRr4EutQ6+l+Jp8Z2du+EVqr/SUGRxkxca
	 5OZ6ZhWwClk6VZxqXMl24H5tEp7wWK7xei85fmhpb0CgGSA1vBH1DPoeSCbftM+IXK
	 67UhdZq6gXxBQ==
Date: Fri, 10 Jan 2025 16:06:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v6 1/6] net: libwx: Add malibox api for wangxun
 pf drivers
Message-ID: <20250110220609.GA317429@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110102705.21846-2-mengyuanlou@net-swift.com>

On Fri, Jan 10, 2025 at 06:27:00PM +0800, Mengyuan Lou wrote:
> Implements the mailbox interfaces for wangxun pf drivers
> ngbe and txgbe.

Maybe not worth reposting just for these nits, but if you do:

In subject:
s/malibox/mailbox/

Throughout in subject, text:
s/vf/VF/
s/pf/PF/
s/sriov/SR-IOV/
s/wangxun/WangXun/
s/nic/NIC/
s/api/API/

