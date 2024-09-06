Return-Path: <netdev+bounces-126047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0A096FC21
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 21:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7C3285259
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8881D31BB;
	Fri,  6 Sep 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2hfXLnF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A61D2F62
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725650818; cv=none; b=EwiCicdHqUnLjBwOx8C1C31Qtl2fsX0CCvzDQNvWHmQm2oWWeVcenf+eHm0HlU+4clr6NlApXby+jbLHRBzSfPLFfaLRjYtOuEdzr+4z63/+02ia7MEKri91AhLjP/qSV1TEj94TufJ+KRSFdPLvqlPfYNWlMsxvvMvWvhR/CJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725650818; c=relaxed/simple;
	bh=F4f+tEHZb96570s06RNyA/N/LYI/RC8GEcsg6hbMUlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1VS9PQ+kZTCmDBQlGq+eWbZNvs6x1YbEQoumrf4fY9jRK18xw416vIKpDbnNoyQT76eehLUCSGEhktTe8p6OvzUOICQB6z3JGq+eie5YfiV1qvqVMDDAqCYPtHlY0O6fA5d4iw8H92ySfoy1u5R7yKClKE0M0DpBhuIgEOEMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2hfXLnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293DEC4CEC7;
	Fri,  6 Sep 2024 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725650818;
	bh=F4f+tEHZb96570s06RNyA/N/LYI/RC8GEcsg6hbMUlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P2hfXLnFmim9T1chBPYRkySErheVadSvlPB9AAKRoA7UfycfHol0RYIP1BFYEP7z7
	 N2u9MDyzthhujCnx1ZZnALx1viMP+gjufD5ncAszEFjupBOEKkm/mF7V+mjzPlKcJ7
	 7TyJBZi2SALVOnYWmyQZVqmhSuhwTn1D3X2z/MYc6gf5fVcbDrOdvsi+I4yxmqT1v1
	 3PwTAJE2aVXndLFCZ5QfJK6uQoizqPojIWqayUQINcaiCI3h2rE/7B2JNjdrXLXbWJ
	 wFBEcFvuBo9ev0VjPZC3neKLrTore8tHh51/CzldSBwYEK+NY+ByLr1JYeGpjJYMwT
	 LstcneyshPevg==
Date: Fri, 6 Sep 2024 20:26:54 +0100
From: Simon Horman <horms@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
	sd@queasysnail.net, donald.hunter@gmail.com
Subject: Re: [PATCH net-next v6 04/25] ovpn: add basic netlink support
Message-ID: <20240906192654.GN2097826@kernel.org>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-5-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827120805.13681-5-antonio@openvpn.net>

On Tue, Aug 27, 2024 at 02:07:44PM +0200, Antonio Quartulli wrote:
> This commit introduces basic netlink support with family
> registration/unregistration functionalities and stub pre/post-doit.
> 
> More importantly it introduces the YAML uAPI description along
> with its auto-generated files:
> - include/uapi/linux/ovpn.h
> - drivers/net/ovpn/netlink-gen.c
> - drivers/net/ovpn/netlink-gen.h
> 
> Cc: donald.hunter@gmail.com
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

...

> diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml

...

> +  -
> +    name: keyconf
> +    attributes:
> +      -
> +        name: slot
> +        type: u32
> +        doc: The slot where the key should be stored
> +        enum: key-slot
> +      -
> +        name: key-id
> +        doc: |
> +          The unique ID for the key. Used to fetch the correct key upon
> +          decryption
> +        type: u32
> +        checks:
> +          max: 7

Hi Antonio,

Here max for keyconf key-id is 7.

...

> diff --git a/drivers/net/ovpn/netlink-gen.c b/drivers/net/ovpn/netlink-gen.c

...

> +/* Common nested types */
> +const struct nla_policy ovpn_keyconf_nl_policy[OVPN_A_KEYCONF_DECRYPT_DIR + 1] = {
> +	[OVPN_A_KEYCONF_SLOT] = NLA_POLICY_MAX(NLA_U32, 1),
> +	[OVPN_A_KEYCONF_KEY_ID] = NLA_POLICY_MAX(NLA_U32, 2),

But here it is 2.

Probably the patch should be refreshed after running:
tools/net/ynl/ynl-regen.sh -f 

> +	[OVPN_A_KEYCONF_CIPHER_ALG] = NLA_POLICY_MAX(NLA_U32, 2),
> +	[OVPN_A_KEYCONF_ENCRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
> +	[OVPN_A_KEYCONF_DECRYPT_DIR] = NLA_POLICY_NESTED(ovpn_keydir_nl_policy),
> +};

...

