Return-Path: <netdev+bounces-31129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956A78BC66
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 03:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED168280E9B
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 01:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85840811;
	Tue, 29 Aug 2023 01:42:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BCB7FF
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 01:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA57C433C7;
	Tue, 29 Aug 2023 01:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693273323;
	bh=+jT31R/v6F0v7pZfz8w3Zwcj3gjg00AZpFFCXY9Kfiw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gSlmT53W4lmXkkmUPor9gCIQGCALituhePq2CCPhumqeLVLmT4rdzwYaNHHF8xzwy
	 dmaSZd+03KxppAG8FHWdWFRYHfeQdgUgLo50leOnDRC9XF3pnktocIUVW6pIivQ6qo
	 onswAn6qcq+kZDTNSBeKbIGhn5HbqFWA7BEtYSX1mK7CUwAnF2NwXKCqrSR8mwDASi
	 G+c2mGQfGIuyKVJ3fR+uxKf2M7OCGwE1Ux+w0jsPfBfvNf7AHfrH9wzkiZxgFVC+wh
	 50j7FQqvEKQD6U8fQuV2J/bj5FtUZMYr6cPwNPZZhXjeu7N5KbkaNBxrXXk+TU+wW1
	 OVygx+YSAcvgg==
Message-ID: <27cb2d89-4a36-ed6d-5439-03d4dd4a0c2e@kernel.org>
Date: Mon, 28 Aug 2023 19:42:02 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [Questions] Some issues about IPv4/IPv6 nexthop route
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>,
 Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Haller <thaller@redhat.com>
References: <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1> <20230724084820.4aa133cc@hermes.local>
 <ZMDyoRzngXVESEd1@Laptop-X1> <ZMKC7jTVF38JAeNb@shredder>
 <ZOxSYqrgndbdL4/M@Laptop-X1>
 <078061ce-1411-d150-893a-d0a950c8866f@kernel.org>
 <ZO1E4iy5hmd4kpHl@Laptop-X1>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZO1E4iy5hmd4kpHl@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/23 7:07 PM, Hangbin Liu wrote:
> As I asked, The type/proto info are ignored and dropped when merge the IPv6
> nexthop entries. How should we deal with this bug? Fix it or ignore it?

ok, yes, that is a bug to me since information passed in is silently
dropped. Please send a patch to fix it.

