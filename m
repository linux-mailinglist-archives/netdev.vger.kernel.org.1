Return-Path: <netdev+bounces-37295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0827B4900
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 20:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id A57EE28198C
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345318C18;
	Sun,  1 Oct 2023 18:03:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3114AD2FC
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 18:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CECC433C7;
	Sun,  1 Oct 2023 18:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696183437;
	bh=ZodjcWfhxOXnDQ1eehS6Akzx8Yb+22bfAhpsgF2YlNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScVpDHQ8Jz5VoCJN1eXnl/YrmFB0H3ONS5hD0IWF2PCkJd+6lHhbBEmdXXsqdt+AK
	 lasPuqgThLunmpBEshae4Kz2pmLIKWqJM7LqF4sd6oLduXxyueI+ZakVFvcDxKVsjA
	 vw0pAFMK03VOXyxF/53AJd8oVNLTW12kNAnY7/E+J3oQ9PBrzkb36gkpOI4TlidXdf
	 BQKzuvrKxMPRGzr+WPma+tEJTfISoCnfAnyo7c+bzFNZnAB5TfWTmPlN/rHnLZavc1
	 Pe8qu+3OtlUAxul7Iqc3p7gAqk5Q8+b5pBEsPgh/6IKDg6Vl0Mv8uU6ZcvxyxrC4+0
	 obYNcQISBDgYw==
Date: Sun, 1 Oct 2023 20:03:53 +0200
From: Simon Horman <horms@kernel.org>
To: chenguohua@jari.cn
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev: Clean up errors in netdevice.h
Message-ID: <20231001180353.GU92317@kernel.org>
References: <2de2b453.859.18ad4b697c8.Coremail.chenguohua@jari.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de2b453.859.18ad4b697c8.Coremail.chenguohua@jari.cn>

On Wed, Sep 27, 2023 at 11:37:30AM +0800, chenguohua@jari.cn wrote:
> Fix the following errors reported by checkpatch:
> 
> ERROR: that open brace { should be on the previous line
> ERROR: spaces required around that '=' (ctx:VxV)
> 
> Signed-off-by: GuoHua Cheng <chenguohua@jari.cn>

Hi GuoHua Cheng,

I'm sorry, but checkpatch cleanup patches for Networking code
are not accepted.

pw-bot: rejected

