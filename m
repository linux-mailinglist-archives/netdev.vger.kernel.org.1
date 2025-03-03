Return-Path: <netdev+bounces-171799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC1A4EBD6
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 19:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0543F168275
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544C6205AC7;
	Tue,  4 Mar 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swyEXDmw"
X-Original-To: netdev@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB72E3371
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112628; cv=pass; b=pNq9KlvmJwYSmgFMgdJn+MI7cczdMUKi1e4JvSzttfxNni/A7pEApCqPUgTWd2f6Jmj3ZXLg2VQhgghzcCoaVMOrCUnNM2Y4LjtpL9Dj13fMY+J1b+uwWPkWa0h/ovFXxUvEi9dne7uOLaZWcLrX0WEe+08C5UM5IwRVpTCHzfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112628; c=relaxed/simple;
	bh=o/Y21k3K8BAtGuRlqRGQ5WfAu2QMrDK4uLxkfdiPHqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeSqHX21dphDmZqXMqw3VFH/6lrt0y3qnDDvs9NSsG/sNVjKvmVtb9tPqNTGxFE/EDLSScGls14hprEjx0sw7NymLe44c3PTNhm8etlNuqbRn99bYu0GiihoM/9yyTbBLG7/a4Z9n5TwnTz5fc2EfAZOElbNAeAcvVRFa1lTPgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swyEXDmw; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id C31EF40D1F5C
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 21:23:44 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=swyEXDmw
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dnT5GNkzFxGd
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:47:25 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 755C84271F; Tue,  4 Mar 2025 17:47:08 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swyEXDmw
X-Envelope-From: <linux-kernel+bounces-541768-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swyEXDmw
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 3292E4205E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:10:35 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 72E112DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:10:34 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DDA7A3FF0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA02116E7;
	Mon,  3 Mar 2025 13:09:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699F121128D;
	Mon,  3 Mar 2025 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741007390; cv=none; b=FdJQf3C0V6z+/iJwkmai9q0EUpkpGnF1m2ZxTM1etBOl94WxqZl777yR/R9sL5atzBdVh3RVqXu90sVcdjcxdVN6ecQDpRS16lrD0gfWxfhs9yViKbruy4/qD7xjW0m7VSrvugKXVdP0+lWjyzXALv0FFGqta0ijY3O0j3N1Kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741007390; c=relaxed/simple;
	bh=o/Y21k3K8BAtGuRlqRGQ5WfAu2QMrDK4uLxkfdiPHqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz7JZMWxnvOViyg8wVY04DyIRkeqKZ+oEu4ZRiyHuhsz5XHQAl4r+EPFNofGblR1kzaeuO1bDyHQYI3x3/kvs/Us9qzqx9ZKaSwV8FxRKnWiUukBuq2XVG0R+M+BLWgV2o04O848YMZn6SrWCeruRRF5vxKBVjOHVAwVhkNbQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swyEXDmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4727C4CED6;
	Mon,  3 Mar 2025 13:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741007389;
	bh=o/Y21k3K8BAtGuRlqRGQ5WfAu2QMrDK4uLxkfdiPHqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=swyEXDmw0R0g7ZRw44ogOiq1HHP3y2FeZWG29C850ReRwgC8lzNdttVBTaHFVe65o
	 zVYLN/A4vGP8u73Ji/YrtcfHWGBO9pVsAXxaZDTIvI6w4WA5owD39ZYG+WPsqvtxtt
	 6rfvzRPiOvRX9p4m3FK9k0hAmJI4VifjelwS3VIi+Qqzx89O2pq8cSMhGEWt4zeX5g
	 /J7PQGlObpo+3VnrZr33tGBzuiHEkzryDdXAGsvjicCP+5GLyi2yw93+6o12fFMSVU
	 ytDYWysry3KgQaYBbbyO5mF0BnaqsPZnYFKudU33iNwWvClH0C+6o57GuX/9dcgFSt
	 U2WifXCRtyomg==
Date: Mon, 3 Mar 2025 13:09:45 +0000
From: Simon Horman <horms@kernel.org>
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lukasz Majewski <lukma@denx.de>,
	MD Danish Anwar <danishanwar@ti.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
Subject: Re: [PATCH net-next v3 2/2] net: hsr: Add KUnit test for PRP
Message-ID: <20250303130945.GS1615191@kernel.org>
References: <20250227050923.10241-1-jkarrenpalo@gmail.com>
 <20250227050923.10241-2-jkarrenpalo@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227050923.10241-2-jkarrenpalo@gmail.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dnT5GNkzFxGd
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741717319.35637@LpZ7G1Avqw/QNVkVZhi1eA
X-ITU-MailScanner-SpamCheck: not spam

On Thu, Feb 27, 2025 at 07:09:23AM +0200, Jaakko Karrenpalo wrote:
> Add unit tests for the PRP duplicate detection
> 
> Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
> ---
> Changes in v2:
> - Changed KUnit tests to compile as built-in only
> Changes in v3:
> - Changed the KUnit tests to compile as a module

Thanks, I see that this addresses Paolo's review of v2
and overall looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>



