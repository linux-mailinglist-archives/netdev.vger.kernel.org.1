Return-Path: <netdev+bounces-233058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6519C0BAE9
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E133A3BE1
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304512C21F4;
	Mon, 27 Oct 2025 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kW3tg6W/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554732C21D3
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761531413; cv=none; b=LHHvpgYQ0GtOB740+4/eB8n66mc2yffwEUJH06a5cq+xItAYGmuplkW5fKD5gmo/i6YLxsIvAHf9IaYY1j4vaDZ8SOZtnt+2ToXzzcKZU1fWx022ly9+445usScypJbv0jFqLlJcZUVl6U8sonroVYfx2Y1HfBBIu6Yo3I9Gnmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761531413; c=relaxed/simple;
	bh=m8okZ+vHavx4szDuDfnXQBUHDXlnW9pc84oaCewpiiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfys5NYJonkChepAxthHjgGzRFrx4pOn+78AFIJ/ORNvm1BvOZVvGHVkfBGksdnGOPs3aK2GLleIdlTPz1KVJEX1XhPGCuicbmnqM4nkCOdl+dvvgUvnNwzX8d/nH1U1BGW6h6tm9M0xnjm/w7cWLq3m/12dOYgK0Wjrg/Z/6JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kW3tg6W/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bp8lv/RA8SKOpDTvF6SAQrhIwgjiI6DBXHsUFbpxpgM=; b=kW3tg6W/6rRWkLido61J+vLRuo
	nsrMhnSZhLeeJFA5FxJRY5Y8Eqpmgv8uLQPX7VpfQRwO59U5HOvpsDM4sOAjltQGNFsJPdi0qry2+
	F+UeqC1HUhOL26S4Rr3MCoO+oFlX1Qe5KvY4m7TJGUi+BPFLaDO4DGCm7ZxJKaCgQ1Jk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDCmu-00C9Ll-QB; Mon, 27 Oct 2025 03:16:48 +0100
Date: Mon, 27 Oct 2025 03:16:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Johannes Eigner <johannes.eigner@a-eberle.de>
Cc: netdev@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
	Danielle Ratson <danieller@nvidia.com>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: Re: [PATCH ethtool v3 2/2] module info: Fix duplicated JSON keys
Message-ID: <f0e2f7ba-e53d-499e-827c-0866dabea861@lunn.ch>
References: <20251024-fix-module-info-json-v3-0-36862ce701ae@a-eberle.de>
 <20251024-fix-module-info-json-v3-2-36862ce701ae@a-eberle.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-fix-module-info-json-v3-2-36862ce701ae@a-eberle.de>

On Fri, Oct 24, 2025 at 12:32:52PM +0200, Johannes Eigner wrote:
> Fix duplicated JSON keys in the module diagnostics output.
> This changes the JSON API in an incompatible way, but leaving it as it
> is is not an option either. The API change is limited to the following
> keys for measured values on QSFP and CMIS modules:
> * "module_temperature" renamed to "module_temperature_measurement"
> * "module_voltage" renamed to "module_voltage_measurement"
> Keys with the same names for threshold values are kept unchanged to
> maximize backward compatibility. Keys for SFP modules are changed as
> well, but since it was never possible to get the diagnostics in JSON
> format for SFP modules, this does not introduce any backward
> compatibility issues for SFP modules. Used key names for SFP modules are
> aligned with QSFP and CMIS modules.
> 
> Duplicated JSON keys result in undefined behavior which is handled
> differently by different JSON parsers. From RFC 8259:
>    Many implementations report the last name/value pair
>    only. Other implementations report an error or fail to parse the
>    object, and some implementations report all of the name/value pairs,
>    including duplicates.
> First behavior can be confirmed for Boost.JSON, nlohmann json,
> javascript (running in Firefox and Chromium), jq, php, python and ruby.
> With these parsers it was not possible to get the measured module
> temperature and voltage, since they were silently overwritten by the
> threshold values.
> 
> Shortened example output for module temperature.
> Without patch:
>   $ ethtool -j -m sfp1
>   [ {
>   ...
>           "module_temperature": 26.5898,
>   ...
>           "module_temperature": {
>               "high_alarm_threshold": 110,
>               "low_alarm_threshold": -45,
>               "high_warning_threshold": 95,
>               "low_warning_threshold": -42
>           },
>   ...
>       } ]
> With patch:
>   $ ethtool -j -m sfp1
>   [ {
>   ...
>           "module_temperature_measurement": 35.793,
>   ...
>           "module_temperature": {
>               "high_alarm_threshold": 110,
>               "low_alarm_threshold": -45,
>               "high_warning_threshold": 95,
>               "low_warning_threshold": -42
>           },
>   ...
>       } ]
> 
> Fixes: 3448a2f73e77 (cmis: Add JSON output handling to --module-info in CMIS modules)
> Fixes: 008167804e54 (module_common: Add helpers to support JSON printing for common value types)
> Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

