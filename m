Return-Path: <netdev+bounces-157332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6198A09FD8
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E77716A567
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF7A9454;
	Sat, 11 Jan 2025 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6G2PZ84"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570F61854
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736557722; cv=none; b=E4Fepat1ywzX9jXacrbwTJ3XxZpLvKXLAmaCDuZCu/yu3rFmNOkqmdAMwDhQiW79kDvCFMIZsEyA+RJYryom0d+RQRAvfyfzHFGjh9lY3h1NQdPyNlIFm0OQu/rjDGXLLaA0bMI7Z8EHoiWjVqjY8nks9EjR097iHuQn1OZDC+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736557722; c=relaxed/simple;
	bh=bj/vnvgh1M6WxtgRU87T9NJwRMex0odSvQTF/dGGgdE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h1kwSDd9MRB/2Dao7lZxarVBeHTnRR/K91vJmY6cIqDNx8sE038ajugDSijuvMA01XFuL+Bdk6kWGomovV5X0UMYBRY8r8KESQon+8IANF/PV+xcGSUEuMJ+TVU1tmqmj5ZM7ls1cESJliCpdYz0TqXqGvcrmX1zZM5GEzBhCek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6G2PZ84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD8FC4CED6;
	Sat, 11 Jan 2025 01:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736557721;
	bh=bj/vnvgh1M6WxtgRU87T9NJwRMex0odSvQTF/dGGgdE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T6G2PZ84Ieotyh+kEx6nQ8llXX2r4CWcR9e+P2IN+WxqzW6VkTQ0DaYRRk2m184hv
	 f4Z5Sn8HwDJVSBPaVrJ9Ti7wGQESL7iXd0FdQhXrWWzExgkIw7yRGync1smilU+Ht9
	 bfG/6N5rdm0cepFw7TQbHEtX1HQKo3m/7KT3qiKGshf+YEPgwTd6li5NRw2++Qin3U
	 eS+3pdJ+Yp2OJ+6V9Fk+Y0gS70oqkQM9pqnP0pOzgmUxkEKAGSJFQw6KDMU/1eXdJt
	 urmXULnf9INoBkJg5Sh35A5+OTLtnYQAsZeqbyxSJZ/cOmEZwOMvZnfnSUyw8Ub8Uj
	 PF5A1OYqqRUdg==
Date: Fri, 10 Jan 2025 17:08:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 1/2] tools/net/ynl: add support for --family
 and --list-families
Message-ID: <20250110170840.0990f829@kernel.org>
In-Reply-To: <20250110144145.3493-1-donald.hunter@gmail.com>
References: <20250110144145.3493-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 14:41:44 +0000 Donald Hunter wrote:
> Add a --family option to ynl to specify the spec by family name instead
> of file path, with support for searching in-tree and system install
> location and a --list-families option to show the available families.

Neat!

>  class YnlEncoder(json.JSONEncoder):
>      def default(self, obj):
> @@ -32,7 +50,14 @@ def main():
>  
>      parser = argparse.ArgumentParser(description=description,
>                                       epilog=epilog)
> -    parser.add_argument('--spec', dest='spec', type=str, required=True)
> +    spec_group = parser.add_mutually_exclusive_group(required=True)
> +    spec_group.add_argument('--family', dest='family', type=str,
> +                            help='name of the netlink FAMILY')
> +    spec_group.add_argument('--list-families', action='store_true',
> +                            help='list all available netlink families')

Do we need to indicate that the list families lists the families for
which we found specs in the filesystem? As opposed to listing all
families currently loaded in the kernel?

Some users may be surprised if they run --list-families, see a family,
issue a request and get an exception that family is not found..

I guess OTOH we also list spec ops in --list-ops, so there's precedent.

Up to you.

> +    if args.family:
> +        spec = f"{spec_dir()}/{args.family}.yaml"
> +        if args.schema is None:

Could we only do this if spec_dir() startswith sys_schema_dir ?

We want to make sure schema is always validated during development.

> +            args.schema = ''
> +    else:
> +        spec = args.spec
> +    if not os.path.isfile(spec):
> +        raise Exception(f"Spec file {spec} does not exist")
> +
> +    ynl = YnlFamily(spec, args.schema, args.process_unknown,
>                      recv_size=args.dbg_small_recv)
>      if args.dbg_small_recv:
>          ynl.set_recv_dbg(True)


