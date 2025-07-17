Return-Path: <netdev+bounces-207905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E66B08FB6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816953A9438
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509382F7CFE;
	Thu, 17 Jul 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbQzHlfp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2830F2BEC28;
	Thu, 17 Jul 2025 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763308; cv=none; b=LXarsQ8LV740TDmQLLTEhjBzippPeDaJLPcB2a/Oznzz1FjaV2kfD25pb0EdOE7++hNynPlw7DKgBMyjsLNWP3zGabGc4GqK9sxUNZZRN4ecngc8k3ThHD8WvN8gx6/djH011OvoAewHFxYcXpLOGC28ZYXhIodEJHOr9V93cgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763308; c=relaxed/simple;
	bh=KB1HImvfD5dHF1nXw+eNM4eRmTzHSdjugW7Iaz186YE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=GYmXxew+JkOX67k/GMe+tz5XUBICUJDrftJSc3BhdZbsLH178Ot5QNSCbRH1JrlMOn6QqJ/MbDBJyzGCzqY4pau4GfsNX5RDpG5NdjGJEE7IlhF8MNMR5So+XXW8kYRSMknDLgV9DhepcilJft/BQt/0eSfP9mu9XdJMPJMUkT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbQzHlfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E56C4CEE3;
	Thu, 17 Jul 2025 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763308;
	bh=KB1HImvfD5dHF1nXw+eNM4eRmTzHSdjugW7Iaz186YE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UbQzHlfpNGu1M2TZxuqoypg/cKE9qS+xxaDRcNxBNyfOTQMMhg7JqAm7XLM4H6gft
	 /Z4trZJvXqWHyZhE4GkuFsGgPJ3J/gxxq4Y7y2hsBGvDGqW+sBXfNzJ0kaL4OawRrG
	 g7L3nWPjdyrIXWzjTjOd1ykaqNBO6awrJ5CLJh9wQoycdn/4ycwaBEvtLYReruCsZp
	 2edZYNQEPEuIKiy+H0sg/a3oDrJd6EY7sUdjY5JmE61MzZcsPJsEmi2tvgrDensji6
	 XUwBoE/oJk1kU2QGsh4VmeC6x5Bxf4XDx8Y+DEsxpTqnC7xbFwATPrUAgGraaEni7Y
	 arwS4vwn76rpw==
Content-Type: multipart/mixed; boundary="------------CCNis5ET97OvOx0N0qVpZYGI"
Message-ID: <8cc52891-3653-4b03-a45e-05464fe495cf@kernel.org>
Date: Thu, 17 Jul 2025 16:41:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] ipv6: mcast: Delay put pmc->idev in mld_del_delrec():
 manual merge
Content-Language: en-GB, fr-BE
To: Yue Haibing <yuehaibing@huawei.com>, pabeni@redhat.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, ap420073@gmail.com, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250714141957.3301871-1-yuehaibing@huawei.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250714141957.3301871-1-yuehaibing@huawei.com>

This is a multi-part message in MIME format.
--------------CCNis5ET97OvOx0N0qVpZYGI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yue, Paolo, Jakub,

On 14/07/2025 16:19, Yue Haibing wrote:
> pmc->idev is still used in ip6_mc_clear_src(), so as mld_clear_delrec()
> does, the reference should be put after ip6_mc_clear_src() return.

FYI, I got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  ae3264a25a46 ("ipv6: mcast: Delay put pmc->idev in mld_del_delrec()")

and this one from 'net-next':

  a8594c956cc9 ("ipv6: mcast: Avoid a duplicate pointer check in
mld_del_delrec()")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side[1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding this conflict, the patch from net has been applied at a
slightly different place after the code refactoring from net-next.

Rerere cache is available in [2].

[1] https://github.com/multipath-tcp/mptcp_net-next/commit/ec9d9e40de20
[2] https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/fe71

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------CCNis5ET97OvOx0N0qVpZYGI
Content-Type: text/x-patch; charset=UTF-8;
 name="ec9d9e40de2017c816864c2193a8a255ddd32815.patch"
Content-Disposition: attachment;
 filename="ec9d9e40de2017c816864c2193a8a255ddd32815.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIG5ldC9pcHY2L21jYXN0LmMKaW5kZXggMGM2M2MzM2FiMDgwLDYxNmJmNGMw
YzhmZC4uMzZjYTI3NDk2YjNjCi0tLSBhL25ldC9pcHY2L21jYXN0LmMKKysrIGIvbmV0L2lw
djYvbWNhc3QuYwpAQEAgLTc4NiwzNCAtNzgzLDM3ICs3ODYsMzQgQEBAIHN0YXRpYyB2b2lk
IG1sZF9kZWxfZGVscmVjKHN0cnVjdCBpbmV0NgogIAkJCWJyZWFrOwogIAkJcG1jX3ByZXYg
PSBwbWM7CiAgCX0KIC0JaWYgKHBtYykgewogLQkJaWYgKHBtY19wcmV2KQogLQkJCXJjdV9h
c3NpZ25fcG9pbnRlcihwbWNfcHJldi0+bmV4dCwgcG1jLT5uZXh0KTsKIC0JCWVsc2UKIC0J
CQlyY3VfYXNzaWduX3BvaW50ZXIoaWRldi0+bWNfdG9tYiwgcG1jLT5uZXh0KTsKIC0JfQog
KwlpZiAoIXBtYykKICsJCXJldHVybjsKICsJaWYgKHBtY19wcmV2KQogKwkJcmN1X2Fzc2ln
bl9wb2ludGVyKHBtY19wcmV2LT5uZXh0LCBwbWMtPm5leHQpOwogKwllbHNlCiArCQlyY3Vf
YXNzaWduX3BvaW50ZXIoaWRldi0+bWNfdG9tYiwgcG1jLT5uZXh0KTsKICAKIC0JaWYgKHBt
YykgewogLQkJaW0tPmlkZXYgPSBwbWMtPmlkZXY7CiAtCQlpZiAoaW0tPm1jYV9zZm1vZGUg
PT0gTUNBU1RfSU5DTFVERSkgewogLQkJCXRvbWIgPSByY3VfcmVwbGFjZV9wb2ludGVyKGlt
LT5tY2FfdG9tYiwKIC0JCQkJCQkgICBtY19kZXJlZmVyZW5jZShwbWMtPm1jYV90b21iLCBw
bWMtPmlkZXYpLAogLQkJCQkJCSAgIGxvY2tkZXBfaXNfaGVsZCgmaW0tPmlkZXYtPm1jX2xv
Y2spKTsKIC0JCQlyY3VfYXNzaWduX3BvaW50ZXIocG1jLT5tY2FfdG9tYiwgdG9tYik7CiAr
CWltLT5pZGV2ID0gcG1jLT5pZGV2OwogKwlpZiAoaW0tPm1jYV9zZm1vZGUgPT0gTUNBU1Rf
SU5DTFVERSkgewogKwkJdG9tYiA9IHJjdV9yZXBsYWNlX3BvaW50ZXIoaW0tPm1jYV90b21i
LAogKwkJCQkJICAgbWNfZGVyZWZlcmVuY2UocG1jLT5tY2FfdG9tYiwgcG1jLT5pZGV2KSwK
ICsJCQkJCSAgIGxvY2tkZXBfaXNfaGVsZCgmaW0tPmlkZXYtPm1jX2xvY2spKTsKICsJCXJj
dV9hc3NpZ25fcG9pbnRlcihwbWMtPm1jYV90b21iLCB0b21iKTsKICAKIC0JCQlzb3VyY2Vz
ID0gcmN1X3JlcGxhY2VfcG9pbnRlcihpbS0+bWNhX3NvdXJjZXMsCiAtCQkJCQkJICAgICAg
bWNfZGVyZWZlcmVuY2UocG1jLT5tY2Ffc291cmNlcywgcG1jLT5pZGV2KSwKIC0JCQkJCQkg
ICAgICBsb2NrZGVwX2lzX2hlbGQoJmltLT5pZGV2LT5tY19sb2NrKSk7CiAtCQkJcmN1X2Fz
c2lnbl9wb2ludGVyKHBtYy0+bWNhX3NvdXJjZXMsIHNvdXJjZXMpOwogLQkJCWZvcl9lYWNo
X3BzZl9tY2xvY2soaW0sIHBzZikKIC0JCQkJcHNmLT5zZl9jcmNvdW50ID0gaWRldi0+bWNf
cXJ2OwogLQkJfSBlbHNlIHsKIC0JCQlpbS0+bWNhX2NyY291bnQgPSBpZGV2LT5tY19xcnY7
CiAtCQl9CiAtCQlpcDZfbWNfY2xlYXJfc3JjKHBtYyk7CiAtCQlpbjZfZGV2X3B1dChwbWMt
PmlkZXYpOwogLQkJa2ZyZWVfcmN1KHBtYywgcmN1KTsKICsJCXNvdXJjZXMgPSByY3VfcmVw
bGFjZV9wb2ludGVyKGltLT5tY2Ffc291cmNlcywKICsJCQkJCSAgICAgIG1jX2RlcmVmZXJl
bmNlKHBtYy0+bWNhX3NvdXJjZXMsIHBtYy0+aWRldiksCiArCQkJCQkgICAgICBsb2NrZGVw
X2lzX2hlbGQoJmltLT5pZGV2LT5tY19sb2NrKSk7CiArCQlyY3VfYXNzaWduX3BvaW50ZXIo
cG1jLT5tY2Ffc291cmNlcywgc291cmNlcyk7CiArCQlmb3JfZWFjaF9wc2ZfbWNsb2NrKGlt
LCBwc2YpCiArCQkJcHNmLT5zZl9jcmNvdW50ID0gaWRldi0+bWNfcXJ2OwogKwl9IGVsc2Ug
ewogKwkJaW0tPm1jYV9jcmNvdW50ID0gaWRldi0+bWNfcXJ2OwogIAl9Ci0gCWluNl9kZXZf
cHV0KHBtYy0+aWRldik7CiArCWlwNl9tY19jbGVhcl9zcmMocG1jKTsKKysJaW42X2Rldl9w
dXQocG1jLT5pZGV2KTsKICsJa2ZyZWVfcmN1KHBtYywgcmN1KTsKICB9CiAgCiAtLyogY2Fs
bGVkIHdpdGggbWNfbG9jayAqLwogIHN0YXRpYyB2b2lkIG1sZF9jbGVhcl9kZWxyZWMoc3Ry
dWN0IGluZXQ2X2RldiAqaWRldikKICB7CiAgCXN0cnVjdCBpZm1jYWRkcjYgKnBtYywgKm5l
eHRwbWM7Cg==

--------------CCNis5ET97OvOx0N0qVpZYGI--

