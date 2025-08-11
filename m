Return-Path: <netdev+bounces-212612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67687B2172C
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A4C1A22DE4
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8322E2F1C;
	Mon, 11 Aug 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MD6VOFn6"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B583279327;
	Mon, 11 Aug 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947003; cv=none; b=rA+8Fei8b6B8qghVwkkRdzgfEY6moDiPELPZnZcvqTBxQTR2YPPDBC2AjVr9WzDlfguUESOJMgIyV5hxyE4qawlBFjpYmwud1B9NQ2JlpRGrjNmGZHflgEmjI2n2ySGXOm8mulRp6dfs5y0/bO1fkgu7CgCq3HGKk9axLJ/hb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947003; c=relaxed/simple;
	bh=MadC2IqgaHgcAq0DfRvJ7NXNysh9PdN/wlfNIz2rIB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtcPTzgxWQk+tm5pN0zFjOV0gHc5QKn1IfMNbJ58IxNZG3uCD2d/WSdeWnaiq+/F9pFm5OpKsE0jrDgrPQPwM5kdWksWhmOk94/1gsClibjlUlnLD2TPbigzA1/UKa2EDJvTLL4wr/6cCIohqHGs1X6qf4lnqn5xYtWkaozMK/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MD6VOFn6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=fBPNp2GS65KMLtP/ejKdIQBxEb6N6W7slMBT7Hdhnxw=; b=MD6VOFn69z9h0ri9r9ykzSarLC
	ziUY8mX+BwttGv1vxXm0FlVXbG3Ly5/eq0gP7a+DeZ0KekcAV/QqKFFPhLuVmMBAnjocJ45PIPm4i
	SWyVQI4gStSv+xk5MJXyMnMGu9oQHUuOlBk2aWKcHVB4FsRYOgWGEKZirpNnvqkCPFsQggz5Y6+fs
	P/EvY7nYgBFr9fScBL34UIQGwkcLj2AfiXGgU0h2wOsvJJpjwe1xkJZBzOv84BJVYst9vh/zwBVVm
	sL6IFd2tHdDRW9YZRBoXxl5bg30T7ZSbe9fvgbCRkZKmnSQIp3h1KCKeh9fPhmiAHBR6vWujOupwR
	o8YK/l2Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulZsl-000000094L3-12WR;
	Mon, 11 Aug 2025 21:16:39 +0000
Message-ID: <ac154cf5-4631-4506-bfe2-9442ef3701db@infradead.org>
Date: Mon, 11 Aug 2025 14:16:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] dpll: zl3073x: Implement devlink flash
 callback
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>,
 Petr Oros <poros@redhat.com>
References: <20250811144009.2408337-1-ivecera@redhat.com>
 <20250811144009.2408337-6-ivecera@redhat.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250811144009.2408337-6-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 8/11/25 7:40 AM, Ivan Vecera wrote:
> +/**
> + * zl3073x_flash_update - Devlink flash update callback
> + * @devlink: devlink structure pointer
> + * @params: flashing parameters pointer
> + * @extack: netlink extack pointer to report errors
> + *
> + * Returns 0 in case of success or negative value otherwise

Preferably with a colon:

    * Returns: 0 in case of success or negative value otherwise


> + */
> +static int
> +zl3073x_devlink_flash_update(struct devlink *devlink,
> +			     struct devlink_flash_update_params *params,
> +			     struct netlink_ext_ack *extack)
> +{
Thanks.
-- 
~Randy


