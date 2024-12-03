Return-Path: <netdev+bounces-148329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B609E1208
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D869B28269B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598A1547CF;
	Tue,  3 Dec 2024 03:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XD0Zjqjt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55122AE68;
	Tue,  3 Dec 2024 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197950; cv=none; b=UyjtaltAKpyROd+2kLJzWV4hP5ueyxb7ELMMm29F0ST+7u7vSLhqtylwjhRJVOVYZP68NSrZuDy1YGQv9Luimw6BqPEU+GO7NedNg88TMD2LSUso3eLQCWn6s+kp6xy+OUGaEtBD/v4zeSbgpG1NO6SpCaDMiCRIbQQkGUZ748k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197950; c=relaxed/simple;
	bh=551G0uIufXA+lOHOTDV30PQxwDalihvt2D9ST7Uyg5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8qAXQOyHcxjfhtlqW7ZAF738gdfUrXmIpWx/cIfg9AVsqfjoTen9dwl7SfDwQ+0z8cBXBdMrHGeHJMSVzL1KTxPcutAlcbEMFDiJRcgG1E41ju9EXsroDhvkaifIk8015235CDaU52qt8lZbS2/qkV8iXlZ4r0YFdQWLM0uYMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XD0Zjqjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9F1C4CECF;
	Tue,  3 Dec 2024 03:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733197950;
	bh=551G0uIufXA+lOHOTDV30PQxwDalihvt2D9ST7Uyg5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XD0ZjqjtfZQCDvslIhTQyI8UMMNmIN8f8dmZNTYqxnhfRE6rbpHJeka1++9q141Dn
	 waHHVJQ7LfSXRbvkRBgdouvsVgjVkskox+1AcHXe/foU+3+maOXjUbq5qK4ydFu+6y
	 eGt7tAjbsYi6XkhKsGyvqhGm22zc62JJYaYAUkfNm7KcIc3UAXgQLiaZJOHCnSCvt7
	 oRa3Kz86AD4qfwpi88dcu6EE9YaR9ETkvSQwb15Nd5g2HuFeQAEj98Wl5trGeAXnie
	 4gYaE1CkEsqAAjGGsxxyQWE5+HNaSP91y76zX+y//WI2IC7Nw8tW3oAjRAfCLpChWI
	 gpLx2VJDJVlpA==
Date: Mon, 2 Dec 2024 19:52:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net,
 andrew+netdev@lunn.ch, kory.maincent@bootlin.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3 0/8] ethtool: generate uapi header from the
 spec
Message-ID: <20241202195228.65c9a49a@kernel.org>
In-Reply-To: <20241202162936.3778016-1-sdf@fomichev.me>
References: <20241202162936.3778016-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Dec 2024 08:29:28 -0800 Stanislav Fomichev wrote:
> We keep expanding ethtool netlink api surface and this leads to
> constantly playing catchup on the ynl spec side. There are a couple
> of things that prevent us from fully converting to generating
> the header from the spec (stats and cable tests), but we can
> generate 95% of the header which is still better than maintaining
> c header and spec separately. The series adds a couple of missing
> features on the ynl-gen-c side and separates the parts
> that we can generate into new ethtool_netlink_generated.h.
> 
> v3:
> - s/Unsupported enum-model/Unsupported message enum-model/ (Jakub)
> - add placeholder doc for header-flags (Jakub)
> 
> v2:
> - attr-cnt-name -> enum-cnt-name (Jakub)
> - add enum-cnt-name documentation (Jakub)
> - __ETHTOOL_XXX_CNT -> __ethtool-xxx-cnt + c_upper (Jakub)
> - keep and refine enum model check (Jakub)
> - use 'header' presence as a signal to omit rendering instead of new
>   'render' property (Jakub)
> - new patch to reverse the order of header dependencies in xxx-user.h
> 
> Stanislav Fomichev (8):
>   ynl: support enum-cnt-name attribute in legacy definitions
>   ynl: skip rendering attributes with header property in uapi mode
>   ynl: support directional specs in ynl-gen-c.py
>   ynl: add missing pieces to ethtool spec to better match uapi header
>   ynl: include uapi header after all dependencies
>   ethtool: separate definitions that are gonna be generated
>   ethtool: remove the comments that are not gonna be generated
>   ethtool: regenerate uapi header from the spec

Looks like doc codegen is unhappy about the missing type definitions:

Documentation/networking/netlink_spec/ethtool.rst:1122: WARNING: Bullet list ends without a blank line; unexpected unindent.
Documentation/networking/netlink_spec/ethtool.rst:2126: ERROR: Unknown target name: Documentation/networking/netlink_spec/ethtool.rst:2131: ERROR: Unknown target name: "ethtool_a_cable_result_code".
Documentation/networking/netlink_spec/ethtool.rst:2136: ERROR: Unknown target name: "ethtool_a_cable_inf_src".

We need to teach it to not link to external types?
-- 
pw-bot: cr

