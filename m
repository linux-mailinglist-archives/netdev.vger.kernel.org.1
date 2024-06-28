Return-Path: <netdev+bounces-107680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A5891BEBF
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 14:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91531C20DA2
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440B61586F5;
	Fri, 28 Jun 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwNoLlz4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA8315572B
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578430; cv=none; b=b4I+cvz5HbRlVtgIRu7ZNIX4TSOnpKnK+Xi5TRgMqSZl9asdGuRwWI1bNLI+gx+GD7cKyyJWUSxZ0c7U+3Ng2p3HJmm8V+BTHZmmUmcJRYQtc+yfLeO0A0AnT4ClB9iJdUTgS7aDdutIYkzzQr7d47cHMt4wV96+ZMi5tdSublE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578430; c=relaxed/simple;
	bh=tUiYCUBWNA88EcOXBErIcA7jZ2sP1XfpQ1tQHvHycmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bhs9wIm/f2/6ipZoyIGvaMt8c8hLWrL9XiEjW7j/ymJWLcEovR0DJlyw4tVHyC6vU1Zlq2c+lPPOvL8jXoUJWqlWLmMKJ4yKH/eVkC51RN8W4us3OOlz5L/kpngkyMa485RQvbdgiIDzY5TwSAXlqgdo+TrPAM0I5V6S8NcoE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwNoLlz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9934CC116B1;
	Fri, 28 Jun 2024 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719578429;
	bh=tUiYCUBWNA88EcOXBErIcA7jZ2sP1XfpQ1tQHvHycmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MwNoLlz4J1a6l3MJerg/3PZN9r+9D1QSHJSGli/Dr60oKuT7DO6pXThvnmoFCwv7Y
	 Czp+YYunoBmYoWmx8O6QFAzd/xuAFtccU4OKkWGUsO10Kxvqf86uhziBopvqfHbXJ9
	 sxch8kySmMMiomE7GzWasOl8+o9Ap57YrMLlByNwGguLdhYBPzjI9AKFaZO8OErRR6
	 2KnuXFPKYP1FAH6arzNS5DH6+LZ4tN4/aAe895TEFS2/WOHmgVJeAigkWtMjSoPzMa
	 usxBW2TePiXVnoRuI19+9Jd7XuV7EWGQF3n4yY2fGPgKYK4OpnKoISDOglYQfYhkhW
	 65m9+RBc4EcdQ==
Date: Fri, 28 Jun 2024 13:40:26 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next 1/6] ice: Remove unused struct ice_prot_lkup_ext
 members
Message-ID: <20240628124026.GA783093@kernel.org>
References: <20240618141157.1881093-1-marcin.szycik@linux.intel.com>
 <20240618141157.1881093-2-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618141157.1881093-2-marcin.szycik@linux.intel.com>

On Tue, Jun 18, 2024 at 04:11:52PM +0200, Marcin Szycik wrote:
> Remove field_off as it's never used.
> 
> Remove done bitmap, as its value is only checked and never assigned.
> Reusing sub-recipes while creating new root recipes is currently not
> supported in the driver.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


