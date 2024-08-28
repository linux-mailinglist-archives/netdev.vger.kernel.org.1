Return-Path: <netdev+bounces-122876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0876962F4B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7B51C22B46
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697B1993AF;
	Wed, 28 Aug 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg1T4o0e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3369611E
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868261; cv=none; b=Gh2oCf6o/CVKVTfDqvQJ+VZMvOKQhVWsjywmeQzwmaGwAeQmZNozFHqLISbUMKQY6JThmhK1EvkkeGcqXvdkOYxT9dc6U1QOmct/rU+9rN5whMbr+XeY6X7Z6pF1VOhgtp0rqNLsjLTJGjooTt6vPkVSeQa31nGF6DN15+zn0eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868261; c=relaxed/simple;
	bh=Io0ZJZ1h3ody/2xxnkufZxTLsu3vNXBS97v5BKsyeUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQEjfIuCWIyDppBbsoQqMGMCK4Ig2mDPYLAb7gj4ouCvabxWM31x21QI0NLZix4mhfL15oarh7wUvDSap1LnezMSEKmtMGYRYuWG5mD0ClqMQWEUYPJ6EJcs5upyBXmmiefRRgc0o+zW4vdaCW3rjNJb1Al6Ijyac44C3xaJUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg1T4o0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0672CC4CEC0;
	Wed, 28 Aug 2024 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724868261;
	bh=Io0ZJZ1h3ody/2xxnkufZxTLsu3vNXBS97v5BKsyeUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cg1T4o0eamXZIJ2OHYQl8K0cKvrPJ4lX9luaNmpZCwYKz4GLuM7gWx7Q1lVLZFop9
	 wptYgIH+C1wdR8KnarIw5dppvC5k8UZrYQLfyChEqoCYtfxXW/hGKdO89FB20Ah5+v
	 aKnU4IkVe4IOSjYNBi1YjFbYuaVLRP60hCaDvlSg9MkYg7emxg4ycIM9qhPfDAMRo3
	 wodv+O1a8eP3X+/EYM0LE3FbcVzBvzr7+BIlJ3SlkNYL7mdELMwU6bKRZx7uK+zbxG
	 TMEPfGlBs5Hkh6eGrrJLladLMaB2QCBWphPhuDcAc3EDmmF7KFfkLZcnLOH+I8sdHT
	 3SXA3Nc5J0iLA==
Date: Wed, 28 Aug 2024 19:04:17 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net] MAINTAINERS: exclude bluetooth and wireless DT
 bindings from netdev ML
Message-ID: <20240828180417.GB2671728@kernel.org>
References: <20240828175821.2960423-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828175821.2960423-1-kuba@kernel.org>

On Wed, Aug 28, 2024 at 10:58:21AM -0700, Jakub Kicinski wrote:
> We exclude wireless drivers from the netdev@ traffic, to delegate
> it to linux-wireless@, and avoid overwhelming netdev@.
> Bluetooth drivers are implicitly excluded because they live under
> drivers/bluetooth, not drivers/net.
> 
> In both cases DT bindings sit under Documentation/devicetree/bindings/net/
> and aren't excluded. So if a patch series touches DT bindings
> netdev@ ends up getting CCed, and these are usually fairly boring
> series.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

