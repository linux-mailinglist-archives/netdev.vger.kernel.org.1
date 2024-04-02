Return-Path: <netdev+bounces-83876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7188A894A92
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1117D1F238BC
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 04:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EB517BBE;
	Tue,  2 Apr 2024 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYYu4cn3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA7182DD
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 04:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033013; cv=none; b=hjv4dmyn/7YcAvVXO+Fm+xruq/ieUvpJiyPaP1VBBbwx5gu/qRMXO5Uh18bEfUa9AwFsoSXDJvqwBIHmnApH/K5a3OJHn3jghh75SSLA8I/xPkFCg20MDfaAIPp9EOHAyq+7P2UACYC+OJKe6c81suByg4U1NG9lJXTbFvPyugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033013; c=relaxed/simple;
	bh=RSUq3aXmNvXGeMxtGdcOH6QI7lcgp1OO85nfISlukOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/dQOKqqpFXmT/8ZBtRqZJWS3U1QovK/V+xaEV8rlt0qphUAuS8JS6Y+LdEE7tnXXN6ImIFLNYGMFJEXJyy/YAFhnleywsZA9f/FtZih5V0KuXFwbgjjXIUl7J0jjVzV3tl6py2zXarZ3DKXCbk2+xcKlTIYZdJDyD8RBFjOFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYYu4cn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2352C433C7;
	Tue,  2 Apr 2024 04:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712033013;
	bh=RSUq3aXmNvXGeMxtGdcOH6QI7lcgp1OO85nfISlukOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jYYu4cn3GpJn1o9NhTsMjCiBfUfs3Y7+3tmZjzBQFP4DZKdO9wj3o5i3RqUFjWqhj
	 D8fGsa2aPe7v2L7kmtMjgpqZ231wM9bjiZ/vioJ8n5bEoVYfXMLv51wY5peXZBp4+D
	 ACY7ouH4yXelUrFOFk+1Y7Mvq2yz6Ck5L8tvDN364+0Djp3ECn8dztDRllj21QNEd0
	 Mjie54cAXsJtHkgYiyjX6YgMQdNfh4J9Ln8yQN5tlIqmrpbQdTJHez/p4lXV5ajNjD
	 ReWKAOLK1IN3MvjeGc+0UPFaFp/MLV7tc/JGP6+8K7Jt6lHc6SzTuRs0SHmaAQgQ9j
	 ebEj7s4DM0Y4g==
Date: Mon, 1 Apr 2024 21:43:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv3 net-next 2/2] ynl: support binary/u32 sub-type for
 indexed-array
Message-ID: <20240401214331.149e0437@kernel.org>
In-Reply-To: <20240401035651.1251874-3-liuhangbin@gmail.com>
References: <20240401035651.1251874-1-liuhangbin@gmail.com>
	<20240401035651.1251874-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Apr 2024 11:56:51 +0800 Hangbin Liu wrote:
> +Other ``sub-type`` like ``u32`` means there is only one member as described
> +in ``sub-type`` in the ``ENTRY``. The structure looks like::
> +
> +  [SOME-OTHER-ATTR]
> +  [ARRAY-ATTR]
> +    [ENTRY]
> +      [MEMBER1]
> +    [ENTRY]
> +      [MEMBER1]

I think that elsewhere in the doc we use [SOMETHING] to mean
TLV of type SOMETHING, here MEMBER1/2 are presumably just
payloads of each ENTRY? Maybe this is better:

  [SOME-OTHER-ATTR]
  [ARRAY-ATTR]
    [ENTRY u32]
    [ENTRY u32]

?

>  type-value
>  ~~~~~~~~~~
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index e5ad415905c7..aa7077cffe74 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -640,6 +640,11 @@ class YnlFamily(SpecFamily):
>              if attr_spec["sub-type"] == 'nest':
>                  subattrs = self._decode(NlAttrs(item.raw), attr_spec['nested-attributes'])
>                  decoded.append({ item.type: subattrs })
> +            elif attr_spec["sub-type"] == 'binary' or attr_spec["sub-type"] == 'u32':
> +                subattrs = item.as_bin()

Are you sure that as_bin() will work for all u32s?
Or just when there's a hint...

> +                if attr_spec.display_hint:
> +                    subattrs = self._formatted_string(subattrs, attr_spec.display_hint)
> +                decoded.append(subattrs)

