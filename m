Return-Path: <netdev+bounces-145666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EE39D05A8
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DEF91F21AB9
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 20:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FF11DBB0C;
	Sun, 17 Nov 2024 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZT7tAp2y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C91DB34E
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731874169; cv=none; b=aInwL7PvKW0jsi9E6YAS22FmfXXCNljASHqTlJokXE/z/eyRgFjmowsuMZDeeNIeR1cULwhzPzRHSASp8NUTQdMOrFgqs2h39x0cbsJykBCB1usu7zqEaZHteix3mYEDVfPtoQyx6J0q5vXE2/oJ0qI7tbc9I8UQpPrAFsZu8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731874169; c=relaxed/simple;
	bh=C4cfhtD4cX36r2arxnj2KM7ZYW+LiUIchcOnjSh/s0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOcjGVFUcT4o4uthMfCT5fv8d0dw601sfXT9m8I0Qn1/9brkOM9uMQ7u6DOzTtB7IdXVs4saHsin0kZVz8h3lygmF6pLDczpP0wA5t4y+cD5mUm2Xygzrs4gfMv70sK768LcLx+cUcjVg0VwEzTzaFXvJrG5Q0cNi/HKLVpa1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZT7tAp2y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kY7rW+fJVpXPwU75w71Pbe4m/olKh11FB36f58kCnD4=; b=ZT7tAp2yK2QlJS9RZCPMWr24mC
	Zsecf9IyDQJGdl70MlmGE8ry650g0xRBNyuIsRRQyZXWCEs+A6aMC/8BF/ZisTBbOQdC578aeMF14
	Ac414BkNh/uTGqpkHnOrqs8IXqG9YidDy0JJvZqAPEy3Qs1XdXwKcGNbPKwEXCBC4EqY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tClaE-00DbHr-LO; Sun, 17 Nov 2024 21:09:22 +0100
Date: Sun, 17 Nov 2024 21:09:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, alexanderduyck@fb.com
Subject: Re: [PATCH net-next 3/5] eth: fbnic: add basic debugfs structure
Message-ID: <3aa56d8a-1170-46c5-bade-48577b933d63@lunn.ch>
References: <20241115015344.757567-1-kuba@kernel.org>
 <20241115015344.757567-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115015344.757567-4-kuba@kernel.org>

On Thu, Nov 14, 2024 at 05:53:42PM -0800, Jakub Kicinski wrote:
> Add the usual debugfs structure:
> 
>  fbnic/
>    $pci-id/
>      device-fileA
>      device-fileB
> 
> This patch only adds the directories, subsequent changes
> will add files.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

This looks a lot better than previous attempts. Thanks.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

