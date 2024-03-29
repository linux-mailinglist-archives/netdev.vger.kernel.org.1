Return-Path: <netdev+bounces-83133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E856890FE9
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 01:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A80D1C22412
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 00:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C1A1118B;
	Fri, 29 Mar 2024 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQGVc2/Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC22210A3D
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711673851; cv=none; b=iECH2FAF/DI+k/Z9hn8lL4dJzqenaMxnGGZQ9CALQF0v/f0hExBhCvv7wUTwsuZdyAAvkMc6o9fBDgVDFWjL8TRIgsy3L2FMbwYHHxBOgSO+WeZpas7HMTWKBIc3CaZhLMzb+KsCKE3dIQrRXl/rHnr16u50i7f5brbIl8Idq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711673851; c=relaxed/simple;
	bh=e2yOawtExir6fVnldDT36vGHSsVIOf2hblQdXUExT5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDQPWZppk9bM7ded+KiAvjToCYle2toXD85hhxEe5RRnxn+yVRvyM84yfpBLt0U9GsOBShCewUhfeUrIuHGBY2sDkqRug8aBzncUuoOBUsx6bX8bgPfnscSHpWdHQQoXjYcgUcWmIYCuMNtUWl0vqMSknXVjDpKe0i17T8l4m7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQGVc2/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7887BC433C7;
	Fri, 29 Mar 2024 00:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711673850;
	bh=e2yOawtExir6fVnldDT36vGHSsVIOf2hblQdXUExT5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iQGVc2/Y+izJ0JJCSMx17Jn8DVwRnBigL7BUTjFkpVRv7vjGpQpzQkqlqKUeu+agh
	 ztCgNs8PEdajitb3ztqxHhnAX1KKpxLO5N+Qh4esgLqdfBBV/PVKDOHTRgqE7Jsw3G
	 6tRh0cMpRG828IivGXxXz+BIPyIPpd3VwJ+TAmHPR6KIEd6Y/uU64fW0dF46v8uG/S
	 Fnr5S4engv4nYza3BWG76g0UVkrEwZKb7wnQ6Dbc0uR6V0yySECNyrZAGNXXwTDz96
	 +p0XwY+kNDsO/a9wMBEvDcICbqGvrsVHgFBXw2T1UWOilwnqtfrg4Iv2Bhnek9Fl2L
	 8ta99nI9ssIzw==
Date: Thu, 28 Mar 2024 17:57:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: Add multi message
 support to ynl
Message-ID: <20240328175729.15208f4a@kernel.org>
In-Reply-To: <20240327181700.77940-3-donald.hunter@gmail.com>
References: <20240327181700.77940-1-donald.hunter@gmail.com>
	<20240327181700.77940-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 18:17:00 +0000 Donald Hunter wrote:
> -    parser = argparse.ArgumentParser(description='YNL CLI sample')
> +    description = """
> +    YNL CLI utility - a general purpose netlink utility that uses YNL specs

YNL specs is intentional or should have been YAML? :)

> +    to drive protocol encoding and decoding.
> +    """
> +    epilog = """
> +    The --multi option can be repeated to include several operations
> +    in the same netlink payload.
> +    """
> +
> +    parser = argparse.ArgumentParser(description=description,
> +                                     epilog=epilog)
>      parser.add_argument('--spec', dest='spec', type=str, required=True)
>      parser.add_argument('--schema', dest='schema', type=str)
>      parser.add_argument('--no-schema', action='store_true')
>      parser.add_argument('--json', dest='json_text', type=str)
> -    parser.add_argument('--do', dest='do', type=str)
> -    parser.add_argument('--dump', dest='dump', type=str)
> +    parser.add_argument('--do', dest='do', metavar='OPERATION', type=str)
> +    parser.add_argument('--dump', dest='dump', metavar='OPERATION', type=str)
>      parser.add_argument('--sleep', dest='sleep', type=int)
>      parser.add_argument('--subscribe', dest='ntf', type=str)
>      parser.add_argument('--replace', dest='flags', action='append_const',
> @@ -40,6 +50,8 @@ def main():
>      parser.add_argument('--output-json', action='store_true')
>      parser.add_argument('--dbg-small-recv', default=0, const=4000,
>                          action='store', nargs='?', type=int)
> +    parser.add_argument('--multi', dest='multi', nargs=2, action='append',
> +                        metavar=('OPERATION', 'JSON_TEXT'), type=str)

We'd only support multiple "do" requests, I wonder if we should somehow
call this out. Is --multi-do unnecessary extra typing?

Code itself looks pretty good!

