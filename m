Return-Path: <netdev+bounces-213855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA1B2719A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78AB756700A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 22:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7856B27FB28;
	Thu, 14 Aug 2025 22:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0Q7jH13"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C81C9DE5;
	Thu, 14 Aug 2025 22:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210429; cv=none; b=uf5IuRFvxThI/ED3MI1WeMWX8psLTpiWUiNKtDNLiSlfB0CtYBebhpRZHUHQQY1NkuJX90JQgfCe3lWcEweETqbw7MZ+W58B3QBQ8bHEcckx/+uqOCS/wnUppWI2QNk7Wv0REctYPHrB5zu2PSi1Q9649+PpIDIeQj6QQ0DOdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210429; c=relaxed/simple;
	bh=ihJiNbq3crEvohcQ6It1P3dL4Tr9QQCo2wRY/rSYaeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvwN4yv9wCCbIdpXFgDZnJBn1ifL8qYgOhNrPXZ4Ht6pGahp1hIoBIuaYjz8lFZRRNk1rrrTV0PMUoFdQMlKgrYKFX4+FBJsVtNbn6yt0JxhnKeRUL3LkUgB0FMVU1dI7A3x+wN7fAurAk6H/GDq0ZsfKhkCT5lOHTUAoOLBV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0Q7jH13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE42C4CEED;
	Thu, 14 Aug 2025 22:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755210428;
	bh=ihJiNbq3crEvohcQ6It1P3dL4Tr9QQCo2wRY/rSYaeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q0Q7jH135MxbppYhKzub1ljudwF5pZ3mhYyRD712Xp/VREwHyd/Vj0ErUDLXb6St4
	 gT20k6vFcAb0Brh8OhmhHj/wWFOs5nZiDr0tgJEf8UjxJ7HopK6yq5FsBFpzA1nYDH
	 rCnCu4tMXWIePnjmjjV7LIT8vKFQTkArmRs8XWNhd0uAu73L6t6XAXCVDoCf7XCcrD
	 g7h7WdqMH688SddqlgQ0tfToJFSrtnedDRx/d2qas9ZydvySW2Y7uX+nd53yYoqhoP
	 jj54TuJkL6acXRriEMLWXAVVH3q53v57+j83IZ+CbqPLW6mBPO1Xwpw3Xd4eP6lgFW
	 XstVjn8uGaTYA==
Date: Thu, 14 Aug 2025 15:27:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, horms@kernel.org,
 jstancek@redhat.com, jacob.e.keller@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tools: ynl: make ynl.c more c++ friendly
Message-ID: <20250814152707.6d16c342@kernel.org>
In-Reply-To: <20250814164413.1258893-1-sdf@fomichev.me>
References: <20250814164413.1258893-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 09:44:13 -0700 Stanislav Fomichev wrote:
> Compiling ynl.c in a C++ code base requires invoking C compiler and
> using extern "C" for the headers. To make it easier, we can add
> small changes to the ynl.c file to make it palatable to the native
> C++ compiler. The changes are:
> - avoid using void* pointer arithmetic, use char* instead
> - avoid implicit void* type casts, add c-style explicit casts
> - avoid implicit int->enum type casts, add c-style explicit casts
> - avoid anonymous structs (for type casts)
> - namespacify cpp version, this should let us compile both ynl.c
>   as c and ynl.c as cpp in the same binary (YNL_CPP can be used
>   to enable/disable namespacing)
> 
> Also add test_cpp rule to make sure ynl.c won't break C++ in the future.

As I mentioned in person, ynl-cpp is a separate thing, and you'd all
benefit from making it more C++ than going the other way and massaging
YNL C.

With that said, commenting below on the few that I think would be okay.

> @@ -224,7 +228,7 @@ static inline void *ynl_attr_data_end(const struct nlattr *attr)
>  
>  #define ynl_attr_for_each_payload(start, len, attr)			\
>  	for ((attr) = ynl_attr_first(start, len, 0); attr;		\
> -	     (attr) = ynl_attr_next(start + len, attr))
> +	     (attr) = ynl_attr_next((char *)start + len, attr))

okay

> @@ -149,7 +153,7 @@ ynl_err_walk(struct ynl_sock *ys, void *start, void *end, unsigned int off,
>  		return n;
>  	}
>  
> -	data_len = end - start;
> +	data_len = (char *)end - (char *)start;

can we make the arguments char * instead of the casts?

>  static void ynl_err_reset(struct ynl_sock *ys)
>  {
> -	ys->err.code = 0;
> +	ys->err.code = YNL_ERROR_NONE;

sure

> @@ -56,6 +60,11 @@ struct ynl_family {
>  	unsigned int ntf_info_size;
>  };
>  
> +struct ynl_sock_mcast {

struct ynl_mcast_grp

> +	unsigned int id;
> +	char name[GENL_NAMSIZ];
> +};

