Return-Path: <netdev+bounces-177331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F12A6F75B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EE6616B355
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51866433A8;
	Tue, 25 Mar 2025 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZTFtWaT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0791E522
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903222; cv=none; b=hFioOUn6goM42wl2CgJY96YQ/TjTl3eykk0zyRU9KyU3PSgT2fZrlabBzDO/N3ZE8fwJtR+1LCHXEQXYwpkE8zU77oMuHxONlLO6eZAiXFF4HveKh3K9E+35EG6D0DkIm5ci8jcScy7+FBp8FspX+rOHIjQB61LnsLkqKXIAdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903222; c=relaxed/simple;
	bh=abhjxjX2KeYPpmSgc/huCWoKyTjZ8vCNokXNF8796p4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewE2n0uI4A0E0eMfDme5Pf4cRmtljVr3KNWfcj8RLN19idu8IiYIyPV1eE6G5aWGKvPE6igZG8fFOER163x8SLD6OCUqgIuU2DxJ/WcWr1MvPhfdq7uiXLrk/g+1vKW7jotoGvP0T4IGYptrSN1CFUwv6H4deUl9Iw83ZgW9H34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZTFtWaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C752C4CEE4;
	Tue, 25 Mar 2025 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742903221;
	bh=abhjxjX2KeYPpmSgc/huCWoKyTjZ8vCNokXNF8796p4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FZTFtWaTdB19Xdd1hG/XlnhsnTurXbXltVBYtdx98D7yIyPnuR+gfQNWc9e1lxiyv
	 17GGLio9qN4ec6SRnTbM8axJiYwy889bUK6Ewiv5dhcxGMjRiAc6zGzunepyJTMfCq
	 A9cINetTeobvh+IViFqZ+likUjsQ5MM8J5xcJdBE7w7rIjT29f7aZ521X/U/b+GxxP
	 euPTyjD9Z4BwjNNqABLv/eXcVnK3KCgS9ZwKzGOLb1LGBjBzN/8iI6Qs2aFboo1eYS
	 SfzEexyvXjxqh4AMhz+twyGqsqi11JmNLFgVsDmVwUHr891oIEU1CZi3MH5GT/6Q2x
	 Z9W8dZ/P0ZWog==
Date: Tue, 25 Mar 2025 04:46:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 parav@nvidia.com
Subject: Re: [PATCH net-next v2 2/4] net/mlx5: Expose serial numbers in
 devlink info
Message-ID: <20250325044653.52fea697@kernel.org>
In-Reply-To: <20250320085947.103419-3-jiri@resnulli.us>
References: <20250320085947.103419-1-jiri@resnulli.us>
	<20250320085947.103419-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 09:59:45 +0100 Jiri Pirko wrote:
> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
> +					     PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
> +	if (start >= 0) {
> +		str = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
> +		if (!str) {
> +			err = -ENOMEM;
> +			goto end;
> +		}
> +		end = strchrnul(str, ' ');
> +		*end = '\0';
> +		err = devlink_info_board_serial_number_put(req, str);
> +		kfree(str);
> +	}
> +
> +	start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size, "V3", &kw_len);
> +	if (start >= 0) {
> +		str = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
> +		if (!str) {
> +			err = -ENOMEM;
> +			goto end;
> +		}
> +		err = devlink_info_serial_number_put(req, str);
> +		kfree(str);
> +	}

I suppose you only expect one of the fields to be populated but 
the code as is doesn't express that.

