Return-Path: <netdev+bounces-272467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MyqAkVHxmmgIAUAu9opvQ
	(envelope-from <netdev+bounces-272467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:00:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC43341690
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4AD6300F9FD
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEF43D9DB3;
	Fri, 27 Mar 2026 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IglS6tQ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844573BED2D
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601744; cv=pass; b=sLyFBpyx4qbAS8haL3UYukB0yMhcVR5YGhThizk5s07i3eNQ12UGGll0+rvJznrr33gebP8eNYMsPK7VvbW7bMk/3tiaXtJi6ECZVZl1x6LLSEaz12ynrD+s4r2++LjwexTX9vcSB7yns3b6zWTIXHW2fq3i6ErJj6M7rXTPAdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601744; c=relaxed/simple;
	bh=8UeDx3YcJwKvTruLriZjWHcVAvboJUZ2/LdgvefG7Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuWXP/ywuLB9+EosYBdJRsQkuiBV3KCffqECY8rfmM78hgmDXYhK91qZj+gjqp9wZd++092nozTl0zzOwEERgyFjWoqYWfkGYU0PKS7TFgbjvvombiuiS5cEPSJNWoMAETwrIeXBCc/aAR/vyl1LUxTJIPfKACmz2Rhnf4FsP7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IglS6tQ1; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d7e5e8c907so1178186a34.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774601742; cv=none;
        d=google.com; s=arc-20240605;
        b=SiPhWxgVGXnb6RraQzZkbgQm+SjBQ1RfnC1oKxzMnQ3hIVjPfZZ+j1lDpJs1u2+Kv/
         XjRYbQcX5oSzh/GFktq7IBMCWwV60AHbSwSLZZX0/y0cW4Gn3aV1R3gwvXTimFT6fTQ+
         S2aIIjSrwIMfVv8C/+0tOMXjtgSabaX5/zv5tYpjJlT5Yqcfobnz6l3eyRockwu5yHxo
         y/ebOZDqGwQ+5pmrEljceDCfbitiyMASiruFBrhHlxOUtDvYvXVAQ2iKs3EpIZn1YMxF
         lNIbUdDAwkZhbzExGMseXBGzdIKNhGGGeU+HnTMbH0h7FCDyqQ4L8ucPU7BJnaO3AZU+
         OF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8UeDx3YcJwKvTruLriZjWHcVAvboJUZ2/LdgvefG7Qg=;
        fh=7ydaQ9ymFSq3Qj7ComF7ttJTQSfmFe8O8iD2CDMmDc4=;
        b=EkjbeqWqmYZq0nOIpZ8/Wckbouw9dYCKVFfBJ0QK4X93VdS9SduW2OaPTj1p0F87i+
         /Ln7mLAlr55MBZfuTqrQ+seDVR7VK7a611hm2k+SEfUro5/Voe3ZdORKb9wMFMJ8LY7N
         B/8xPWdotM8PyTSoJRSti2uqHcljqtRAWlYv5xH1Lzk8xAspLbRBvB4cFUr8DYGKshtr
         Xn+f7cbzSFEtHQA3qx+nyBwGJs5hG1bT4OPPelazer5ZRWb3vMMJK+6Mn5zZBIxTCRz3
         LLV/9saLaIBHe9IH95SNJOkK7gljgpPq7X/4DdFrXrTxFbcqhQGcMt8wRuqns6norups
         htTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774601742; x=1775206542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8UeDx3YcJwKvTruLriZjWHcVAvboJUZ2/LdgvefG7Qg=;
        b=IglS6tQ1kT98PuQVEJ/9vIkSbSQyWVnGpcOnD1sq1NChMAi9+JZ0SbKmyYQD30uPyD
         RViBypQ7Hp2REZRbdgCmFYzT/UK4A9GP+Fj5+oZAE7HbhuxpmivIAfnXv4Qb/vQHIiYn
         9lzP3AEA9a/bF29qml63ddnPqB7H+lHiaqMPw0smovdnjGPtdnQbWuK3/BxxaWO6z5xi
         +SE8caXgBzIhFOzZvSv6QJI2HCT3+H6WAOzcf9ZOUwJQ6n0MbjofBrt+FlH3dMSbUtKo
         QJfG3vsd+3+9lqEE5zP1yNqpXMCqAw7PzEUgcQrSkpd2Ahmp6/EgsT3jShCZamH1Nj5t
         Tx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774601742; x=1775206542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UeDx3YcJwKvTruLriZjWHcVAvboJUZ2/LdgvefG7Qg=;
        b=g9HhnHjB02CSp69sXyX21jHqTfz7fSR0v0mpv7xcb6IciV7iBVxgVyfw9oVrRNT1Jh
         mgI4wAsGWdA52yprJdYXW2a8Yv0wOVla6pPmhg4g7BFkIt3sp2zq0XapOC7IvUZ+q3NC
         ZBilOpW+l/lcKZhVxo1afoESpgbaxZYoMjzze8obaNPI086+j4jK73AtUC/JmlWVEI5f
         YiZ6SqR5ZX+H3zDp5W1vr/TC4u4W6rIsUuxMh2hR5cbO9aKT/VMtNr6gc8hhszeCheCb
         Jq9W0D6moEUOXjwUQXzvYcFStnV6WGnLQYodzMGE1CeymcvX6GW8eqiw+XqIhX92zqoW
         in6Q==
X-Gm-Message-State: AOJu0YxWK+/uv+gH8m377oHrnkY7VjRvy+PoiodfPnS0lVcSkjHcQu/s
	QmuqVyhDl9J21ypuZ7R3cf/3psBfSkyQDPYMsGkv8dAiU1jC2hoiy35NFCEoSn/9t+Q5yupfe0J
	ryd8FoaaP/7W72NUAxDl5YpFTzXaUqR9m2U75t9A=
X-Gm-Gg: ATEYQzx88GA34wGqEMC5N3ButULUIcsnwny2QCXdCNqzqq+3syw95gG1Ve73Xr8X1Q3
	7HIccJR46k27upNPaEbJmV5QUb9jPT5FXMCeXP2R/iYuFLgruoYH7wvad9tGdohWOiFGqw4s4zc
	UvyLTJAZ3S5UrjqXrUqGpqzD5/NXZsv8vvikdTryUlYkTjxDC86X+W0euOmeR6khfJyXGGjfc9f
	2Js59qkICaTn39cRAkgVHR2u0BeoiBzRoo4kTz+3oAyD8WF4g63VtCeVAqxaW7oBkF9A6E8o4C1
	pmHaMYqr88tRPnbR1lj3EY23cN0yApUu9VvIMXgx3yjgysNSa38pCCrDHQu6iNUzYDus
X-Received: by 2002:a05:6820:1746:b0:67a:2ff:91b0 with SMTP id
 006d021491bc7-67e185f6198mr757083eaf.3.1774601742384; Fri, 27 Mar 2026
 01:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324080730.4051666-1-nickgarlis@gmail.com> <20260326203646.2da52419@kernel.org>
In-Reply-To: <20260326203646.2da52419@kernel.org>
From: Nikolaos Gkarlis <nickgarlis@gmail.com>
Date: Fri, 27 Mar 2026 09:55:31 +0100
X-Gm-Features: AQROBzBE9sNWESWLlPyFHmXvgfF-G49bmzGAUszR-lFSp9bJ-i3w1oYKu6ORBcI
Message-ID: <CA+jwDRk_pg6jLsg_nZ+DwHKcLk-TjbhS5o8aveOD5ns=yxUYCg@mail.gmail.com>
Subject: Re: [PATCH] rtnetlink: add missing netlink_ns_capable() check for
 peer netns
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272467-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nickgarlis@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gist.githubusercontent.com:url]
X-Rspamd-Queue-Id: 8BC43341690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

I've created a crude reproduction script using some AI. If that helps,
you can find it here:
https://gist.githubusercontent.com/nickgarlis/5a5815d438aa19b409806712f35f2cb1/raw/c7e2dd0902f1f53f5750f7bbd3ba39ff0b21e43e/inject_iface.c

> AI assistant here suggests this is not the valid Fixes tag,
> which seems true on the surface. This commit was fixing
> cleanup, IDK how it could break input validation?

I went back to check and ran the test against 7a0ea70da56e (the commit
prior) and it does seem like it was broken then too. I think I must have
messed up my testing process when I initially submitted the patch.

It also seems like the bug was always there or at least - almost always
- since Iassume it wasn't a problem before unprivileged namespaces
were introduced ?

In that case, should the tags point to the introduction of the
attributes (like shown below) or point to the introduction of
the namespaces ?

Fixes: 0eb87b02a705 ("veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.")
Fixes: 6b84e558e95d ("vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.")
Fixes: fefd5d082172 ("netkit: Set IFLA_NETKIT_PEER_INFO to
netkit_link_ops.peer_type.")

> Reported-by tags are only when the reporter is different than author
> the Google's bounty program rules have been amended to make this
> explicit, please let us know if other programs still mislead people

That was a mistake on my part, not going through the docs properly.
I'll fix all of the tags in a V2 if you want to accept the patch.

